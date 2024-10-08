import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/note/note_model.dart';

import './note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  NoteRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<NoteModel>> list(bool? complete) async {
    var where = '';
    if (complete != null) {
      where = ' where complete = ${complete ? '1' : '0'}';
    }

    final conn = await _sqliteConnectionFactory.openConnection();
    final notes = await conn.rawQuery(
        'select * from ${Constants.TABLE_NOTES} $where order by date desc');
    return notes.map((e) => NoteModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(NoteModel note) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    note.createdAt = DateTime.now();
    note.updatedAt = DateTime.now();
    await conn.insert(Constants.TABLE_NOTES, note.toMap());
  }

  @override
  Future<void> update(NoteModel note) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    note.updatedAt = DateTime.now();
    final map = note.toMap();
    map.remove('created_at');
    await conn.update(
      Constants.TABLE_NOTES,
      map,
      where: 'id=?',
      whereArgs: [note.id],
    );
  }
}
