import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/exceptions/repository_exception.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/string_utils.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/models/sync/reader_sync_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

import './reader_repository.dart';

class ReaderRepositoryImpl implements ReaderRepository {
  final SqliteConnectionFactory _connectionFactory;
  final DioRestClient _dio;

  ReaderRepositoryImpl(
      {required SqliteConnectionFactory connectionFactory,
      required DioRestClient dio})
      : _connectionFactory = connectionFactory,
        _dio = dio;

  @override
  Future<List<ReaderModel>> list(String? filter) async {
    final conn = await _connectionFactory.openConnection();
    var where = '';
    if (filter != null && filter.isNotEmpty) {
      where = ' where name_diacritics like "%${filter.toLowerCase()}%"';
    }
    final readers = await conn.rawQuery(
        'select * from ${Constants.TABLE_READER} $where order by name_diacritics asc');
    return readers.map((e) => ReaderModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(ReaderModel reader) async {
    final conn = await _connectionFactory.openConnection();
    await conn.insert(Constants.TABLE_READER, reader.toMap());
  }

  @override
  Future<void> update(ReaderModel reader) async {
    final conn = await _connectionFactory.openConnection();
    final map = reader.toMap();
    await conn.update(
      Constants.TABLE_READER,
      map,
      where: 'id=?',
      whereArgs: [reader.id],
    );
  }

  @override
  Future<void> borrowBook(int id, bool borrow) async {
    final conn = await _connectionFactory.openConnection();
    final map = {
      'open_loan': borrow ? 1 : 0,
      'sync': 0,
    };
    await conn.update(
      Constants.TABLE_READER,
      map,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  @override
  Future<ReaderModel> get(int id) async {
    final conn = await _connectionFactory.openConnection();
    final reader = await conn
        .rawQuery('Select * from ${Constants.TABLE_READER} where id=?', [id]);
    if (reader.isNotEmpty) {
      return ReaderModel.fromMap(reader[0]);
    }
    throw RepositoryException('Leitor não encontrada');
  }

  @override
  Future<void> sendData(String url, String token) async {
    final conn = await _connectionFactory.openConnection();
    final results = await conn.query(
      Constants.TABLE_READER,
      where: 'sync=?',
      whereArgs: [0],
    );
    if (results.isNotEmpty) {
      final List<ReaderModel> books =
          results.map((e) => ReaderModel.fromMap(e)).toList();
      final response = await _dio.post(
        '${url}sync/readers',
        data: books.map((e) => e.toJson()).toList(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = response.data["data"];
      final List<ReaderSyncModel> registers = [];
      for (final register in data) {
        registers.add(ReaderSyncModel.fromMap(register));
      }
      if (registers.isNotEmpty) {
        for (final register in registers) {
          final data = {
            "sync": 1,
            "remote_id": register.id,
          };
          await conn.update(
            Constants.TABLE_READER,
            data,
            where: "id=?",
            whereArgs: [register.mobileId],
          );
        }
      }
    }
  }

  @override
  Future<SyncModel> receiveData(String url, String token, DateTime date) async {
    final conn = await _connectionFactory.openConnection();
    final results = await _dio.get(
      '${url}sync/readers?date=${date.toIso8601String()}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = results.data['data'];
    for (final register in data) {
      final readerSync = ReaderSyncModel.fromMap(register);
      final readerRemote = await conn.query(
        Constants.TABLE_READER,
        where: 'remote_id=?',
        whereArgs: [readerSync.id],
      );
      final book = ReaderModel(
        id: readerSync.mobileId,
        name: readerSync.name,
        sync: true,
        openLoan: readerSync.openLoan,
        phone: readerSync.phone,
        address: readerSync.address,
        city: readerSync.city,
        email: readerSync.email,
        remoteId: readerSync.id,
        nameDiacritics:
            StringUtils.removeDiacritics(readerSync.name).toLowerCase(),
      );
      if (readerRemote.isEmpty) {
        await conn.insert(
          Constants.TABLE_READER,
          book.toMap(),
        );
      } else {
        await conn.update(
          Constants.TABLE_READER,
          book.toMap(),
          where: 'id=?',
          whereArgs: [readerSync.mobileId],
        );
      }
    }
    return SyncModel(created: 1, updated: 1);
  }
}
