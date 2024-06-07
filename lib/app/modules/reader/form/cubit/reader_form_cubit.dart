import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/modules/reader/form/cubit/reader_form_state.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';

class ReaderFormCubit extends Cubit<ReaderFormState> {
  final ReaderService _readerService;

  ReaderFormCubit(this._readerService) : super(const ReaderFormState.initial());

  Future<void> save(ReaderModel reader) async {
    try {
      emit(state.copyWith(status: ReaderFormStatus.loading));
      await _readerService.save(reader);
      emit(state.copyWith(status: ReaderFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: ReaderFormStatus.error));
    }
  }
}
