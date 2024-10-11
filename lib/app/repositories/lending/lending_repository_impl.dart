import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';

import 'lending_repository.dart';

class LendingRepositoryImpl implements LendingRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  LendingRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

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
}
