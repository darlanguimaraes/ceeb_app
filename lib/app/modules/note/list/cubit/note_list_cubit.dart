import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/note/note_model.dart';
import 'package:ceeb_app/app/modules/note/list/cubit/note_list_state.dart';
import 'package:ceeb_app/app/services/note/note_service.dart';

class NoteListCubit extends Cubit<NoteListState> {
  final NoteService _noteService;

  NoteListCubit(this._noteService) : super(NoteListState.initial());

  Future<void> list(bool? complete) async {
    try {
      emit(state.copyWith(status: NoteListStatus.loading));
      final notes = await _noteService.list(complete);
      emit(state.copyWith(
        status: NoteListStatus.loaded,
        notes: notes,
      ));
    } catch (e, s) {
      log('Erro ao buscar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: NoteListStatus.error));
    }
  }

  Future<void> update(NoteModel note) async {
    try {
      emit(state.copyWith(status: NoteListStatus.loading));
      await _noteService.update(note);
      emit(state.copyWith(status: NoteListStatus.updated));
    } catch (e, s) {
      log('Erro ao buscar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: NoteListStatus.error));
    }
  }
}
