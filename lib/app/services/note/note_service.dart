import 'package:ceeb_app/app/models/note/note_model.dart';

abstract interface class NoteService {
  Future<void> save(NoteModel note);
  Future<void> update(NoteModel note);
  Future<List<NoteModel>> list(bool? complete);
}
