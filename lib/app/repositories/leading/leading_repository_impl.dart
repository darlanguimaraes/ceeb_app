import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';

import './leading_repository.dart';

class LeadingRepositoryImpl implements LeadingRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  LeadingRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<LeadingModel>> list(String? filter, bool? returned) async {
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
      from ${Constants.TABLE_LEADING} l
        inner join ${Constants.TABLE_BOOK} b on l.book_id=b.id
        inner join ${Constants.TABLE_READER} r on l.reader_id=r.id
      $where
      order by l.date desc''');
    return result.map((e) => LeadingModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(LeadingModel leading) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(Constants.TABLE_LEADING, leading.toMap());
  }

  @override
  Future<void> update(LeadingModel leading) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = leading.toMap();
    map.remove('created_at');
    await conn.update(
      Constants.TABLE_LEADING,
      map,
      where: 'id=?',
      whereArgs: [leading.id],
    );
  }
}
