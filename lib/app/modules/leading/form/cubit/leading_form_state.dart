// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';

part 'leading_form_state.g.dart';

@match
enum LeadingFormStatus {
  initial,
  loading,
  loaded,
  success,
  error,
}

class LeadingFormState extends Equatable {
  final LeadingFormStatus status;
  final List<ReaderModel> readers;
  final List<BookModel> books;

  const LeadingFormState({
    required this.status,
    required this.readers,
    required this.books,
  });

  LeadingFormState.initial()
      : status = LeadingFormStatus.initial,
        readers = [],
        books = [];

  @override
  List<Object> get props => [status];

  LeadingFormState copyWith({
    LeadingFormStatus? status,
    List<ReaderModel>? readers,
    List<BookModel>? books,
  }) {
    return LeadingFormState(
      status: status ?? this.status,
      readers: readers ?? this.readers,
      books: books ?? this.books,
    );
  }
}
