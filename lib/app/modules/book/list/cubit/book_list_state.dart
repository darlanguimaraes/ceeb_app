// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/book/book_model.dart';

part 'book_list_state.g.dart';

@match
enum BookListStatus {
  initial,
  loading,
  loaded,
  error,
}

class BookListState extends Equatable {
  final BookListStatus status;
  final List<BookModel> books;

  const BookListState({
    required this.status,
    required this.books,
  });

  BookListState.initial()
      : status = BookListStatus.initial,
        books = [];

  @override
  List<Object> get props => [status, books];

  BookListState copyWith({
    BookListStatus? status,
    List<BookModel>? books,
  }) {
    return BookListState(
      status: status ?? this.status,
      books: books ?? this.books,
    );
  }
}
