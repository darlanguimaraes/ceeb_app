// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';

part 'lending_form_state.g.dart';

@match
enum LendingFormStatus {
  initial,
  loading,
  loaded,
  success,
  error,
}

class LendingFormState extends Equatable {
  final LendingFormStatus status;
  final List<ReaderModel> readers;
  final List<BookModel> books;

  const LendingFormState({
    required this.status,
    required this.readers,
    required this.books,
  });

  LendingFormState.initial()
      : status = LendingFormStatus.initial,
        readers = [],
        books = [];

  @override
  List<Object> get props => [status];

  LendingFormState copyWith({
    LendingFormStatus? status,
    List<ReaderModel>? readers,
    List<BookModel>? books,
  }) {
    return LendingFormState(
      status: status ?? this.status,
      readers: readers ?? this.readers,
      books: books ?? this.books,
    );
  }
}
