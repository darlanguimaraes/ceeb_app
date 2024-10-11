import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';

import './reader_repository.dart';

class ReaderRepositoryImpl implements ReaderRepository {
  final SqliteConnectionFactory _connectionFactory;

  ReaderRepositoryImpl({required SqliteConnectionFactory connectionFactory})
      : _connectionFactory = connectionFactory;

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
}
