import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/book/list/cubit/book_list_state.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';

class BookListCubit extends Cubit<BookListState> {
  final BookService _bookService;

  BookListCubit(this._bookService) : super(BookListState.initial());

  Future<void> list(String? filter) async {
    try {
      emit(state.copyWith(status: BookListStatus.loading));
      final books = await _bookService.list(filter);
      emit(state.copyWith(
        status: BookListStatus.loaded,
        books: books,
      ));
    } catch (e, s) {
      log('Erro ao buscar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: BookListStatus.error));
    }
  }
}
