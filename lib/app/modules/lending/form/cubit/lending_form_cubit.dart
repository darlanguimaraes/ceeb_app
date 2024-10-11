import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/modules/lending/form/cubit/lending_form_state.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/lending/lending_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';

class LendingFormCubit extends Cubit<LendingFormState> {
  final LendingService _lendingService;
  final ReaderService _readerService;
  final BookService _bookService;

  LendingFormCubit(
    this._lendingService,
    this._readerService,
    this._bookService,
  ) : super(LendingFormState.initial());

  Future<void> save(LendingModel lending) async {
    try {
      emit(state.copyWith(status: LendingFormStatus.loading));
      if (lending.id == null) {
        await _lendingService.save(lending);
      } else {
        await _lendingService.update(lending);
      }
      emit(state.copyWith(status: LendingFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar', error: e, stackTrace: s);
      emit(state.copyWith(status: LendingFormStatus.error));
    }
  }

  Future<void> loadDependencies() async {
    try {
      emit(state.copyWith(status: LendingFormStatus.loading));
      final readers = await _readerService.list(null);
      final books = await _bookService.list(null);
      emit(state.copyWith(
        status: LendingFormStatus.loaded,
        readers: readers,
        books: books,
      ));
    } catch (e, s) {
      log('Não foi possível buscar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: LendingFormStatus.error));
    }
  }
}
