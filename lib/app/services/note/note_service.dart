import 'package:ceeb_app/app/models/node/note_model.dart';

abstract interface class NoteService {
  Future<void> save(NoteModel note);
  Future<List<NoteModel>> list(bool? complete);
}