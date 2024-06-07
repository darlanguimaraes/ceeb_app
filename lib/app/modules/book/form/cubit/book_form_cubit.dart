import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/modules/book/form/cubit/book_form_state.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';

class BookFormCubit extends Cubit<BookFormState> {
  final BookService _bookService;

  BookFormCubit(this._bookService) : super(const BookFormState.initial());

  Future<void> save(BookModel book) async {
    try {
      emit(state.copyWith(status: BookFormStatus.loading));
      await _bookService.save(book);
      emit(state.copyWith(status: BookFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: BookFormStatus.error));
    }
  }
}
