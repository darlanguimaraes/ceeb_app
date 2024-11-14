import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/models/sync/lending_sync_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';
import 'package:sqflite/sqflite.dart';

import 'lending_repository.dart';

class LendingRepositoryImpl implements LendingRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  final DioRestClient _dio;

  LendingRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    required DioRestClient dio,
  })  : _sqliteConnectionFactory = sqliteConnectionFactory,
        _dio = dio;

  @override
  Future<List<LendingModel>> list(String? filter, bool? returned) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    var where = '';
    if (filter != null || returned != null) {
      where = ' where 1=1 ';
      if (filter != null) {
        where +=
            ' and (lower(b.name) like "%${filter.toLowerCase()}%" or lower(b.code) like "%${filter.toLowerCase()}%")';
      }
      if (returned != null) {
        where += ' and l.returned = ${returned ? 1 : 0}';
      }
    }
    final result = await conn.rawQuery('''
      select 
        l.id, 
        l.date, 
        l. expected_date, 
        l.delivery_date, 
        l.returned, 
        l.sync,
        b.id as book_id, 
        b.name as book_name, 
        b.code as book_code, 
        r.id as reader_id, 
        r.name as reader_name
      from ${Constants.TABLE_LENDING} l
        inner join ${Constants.TABLE_BOOK} b on l.book_id=b.id
        inner join ${Constants.TABLE_READER} r on l.reader_id=r.id
      $where
      order by l.date desc''');
    return result.map((e) => LendingModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(LendingModel leading) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(Constants.TABLE_LENDING, leading.toMap());
  }

  @override
  Future<void> update(LendingModel leading) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = leading.toMap();
    await conn.update(
      Constants.TABLE_LENDING,
      map,
      where: 'id=?',
      whereArgs: [leading.id],
    );
  }

  @override
  Future<LendingModel> get(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn
        .rawQuery('select * from ${Constants.TABLE_LENDING} where id=$id');
    return LendingModel.fromMap(result[0]);
  }

  @override
  Future<void> renewLending(int id, DateTime expectedDate) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = {
      'expected_date': expectedDate.millisecondsSinceEpoch,
      'sync': 0,
    };
    await conn.update(
      Constants.TABLE_LENDING,
      map,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> returnLending(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = {
      'returned': 1,
      'delivery_date': DateTime.now().millisecondsSinceEpoch,
      'sync': 0,
    };
    await conn.update(
      Constants.TABLE_LENDING,
      map,
      where: 'id=?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> sendData(String url, String token) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await conn.rawQuery(
        '''select l.id, l.date, l.expected_date, l.delivery_date, l.returned, l.remote_id, l.sync,
    b.remote_id as book_id, r.remote_id as reader_id
    from ${Constants.TABLE_LENDING} l
    join ${Constants.TABLE_BOOK} b on b.id=l.book_id
    join ${Constants.TABLE_READER} r on r.id=l.reader_id
    where l.sync=0''');

    if (results.isNotEmpty) {
      final response = await _dio.post(
        '${url}sync/lendings',
        data: results.toList(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = response.data["data"];
      final List<LendingSyncModel> registers = [];
      for (final register in data) {
        registers.add(LendingSyncModel.fromMap(register));
      }
      if (registers.isNotEmpty) {
        for (final register in registers) {
          final data = {
            "sync": 1,
            "remote_id": register.id,
          };
          await conn.update(
            Constants.TABLE_LENDING,
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
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await _dio.get(
      '${url}sync/lendings?date=${date.toIso8601String()}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = results.data['data'];
    for (final register in data) {
      final lendingSync = LendingSyncModel.fromMap(register);
      final lendingRemote = await conn.query(
        Constants.TABLE_LENDING,
        where: 'remote_id=?',
        whereArgs: [lendingSync.id],
      );
      final readerId = await findByRemoteId(
        conn,
        lendingSync.readerId,
        Constants.TABLE_READER,
      );
      final bookId =
          await findByRemoteId(conn, lendingSync.bookId, Constants.TABLE_BOOK);

      final book = LendingModel(
        id: lendingSync.mobileId,
        sync: true,
        bookId: bookId,
        readerId: readerId,
        remoteId: lendingSync.id,
        date: lendingSync.date,
        expectedDate: lendingSync.expectedDate,
        deliveryDate: lendingSync.deliveryDate,
        returned: lendingSync.returned,
      );
      if (lendingRemote.isEmpty) {
        await conn.insert(
          Constants.TABLE_LENDING,
          book.toMap(),
        );
      } else {
        await conn.update(
          Constants.TABLE_LENDING,
          book.toMap(),
          where: 'id=?',
          whereArgs: [lendingSync.mobileId],
        );
      }
    }
    return SyncModel(created: 1, updated: 1);
  }

  Future<int> findByRemoteId(Database conn, String id, String table) async {
    final reader = await conn.query(
      table,
      columns: ['id'],
      where: 'remote_id=?',
      whereArgs: [id],
    );
    if (reader.isNotEmpty) {
      final data = reader[0];
      return data["id"] as int;
    }
    return 0;
  }
}
