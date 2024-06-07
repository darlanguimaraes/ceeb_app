import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/node/note_model.dart';
import 'package:isar/isar.dart';

import './note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final IsarHelper _isarHelper;

  NoteRepositoryImpl({required IsarHelper isarHelper})
      : _isarHelper = isarHelper;

  @override
  Future<List<NoteModel>> list(bool? complete) async {
    final isar = await _isarHelper.init();
    return await isar.noteModels.where().sortByDateDesc().findAll();
  }

  @override
  Future<void> save(NoteModel note) async {
    final isar = await _isarHelper.init();
    await isar.writeTxn(() async {
      await isar.noteModels.put(note);
    });
  }
}
