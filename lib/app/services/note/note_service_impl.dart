import 'package:ceeb_app/app/models/note/note_model.dart';
import 'package:ceeb_app/app/repositories/note/note_repository.dart';

import './note_service.dart';

class NoteServiceImpl implements NoteService {
  final NoteRepository _noteRepository;

  NoteServiceImpl({required NoteRepository noteRepository})
      : _noteRepository = noteRepository;

  @override
  Future<List<NoteModel>> list(bool? complete) async {
    return await _noteRepository.list(complete);
  }

  @override
  Future<void> save(NoteModel note) async {
    await _noteRepository.save(note);
  }

  @override
  Future<void> update(NoteModel note) async {
    await _noteRepository.update(note);
  }
}
