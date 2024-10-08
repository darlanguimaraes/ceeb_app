import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/note/note_model.dart';
import 'package:ceeb_app/app/modules/note/form/cubit/note_form_state.dart';
import 'package:ceeb_app/app/services/note/note_service.dart';

class NoteFormCubit extends Cubit<NoteFormState> {
  final NoteService _noteService;

  NoteFormCubit(this._noteService) : super(const NoteFormState.initial());

  Future<void> save(NoteModel note) async {
    try {
      emit(state.copyWith(status: NoteFormStatus.loading));
      if (note.id == null) {
        await _noteService.save(note);
      } else {
        await _noteService.update(note);
      }
      emit(state.copyWith(status: NoteFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar', error: e, stackTrace: s);
      emit(state.copyWith(status: NoteFormStatus.error));
    }
  }
}
