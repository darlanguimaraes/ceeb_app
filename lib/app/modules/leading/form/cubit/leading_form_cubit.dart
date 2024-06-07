import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/modules/leading/form/cubit/leading_form_state.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/leading/leading_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';

class LeadingFormCubit extends Cubit<LeadingFormState> {
  final LeadingService _leadingService;
  final ReaderService _readerService;
  final BookService _bookService;

  LeadingFormCubit(
    this._leadingService,
    this._readerService,
    this._bookService,
  ) : super(LeadingFormState.initial());

  Future<void> save(LeadingModel leading) async {
    try {
      emit(state.copyWith(status: LeadingFormStatus.loading));
      await _leadingService.save(leading);
      emit(state.copyWith(status: LeadingFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar', error: e, stackTrace: s);
      emit(state.copyWith(status: LeadingFormStatus.error));
    }
  }

  Future<void> loadDependencies() async {
    try {
      emit(state.copyWith(status: LeadingFormStatus.loading));
      final readers = await _readerService.list(null);
      final books = await _bookService.list(null);
      emit(state.copyWith(
        status: LeadingFormStatus.loaded,
        readers: readers,
        books: books,
      ));
    } catch (e, s) {
      log('Não foi possível buscar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: LeadingFormStatus.error));
    }
  }
}
