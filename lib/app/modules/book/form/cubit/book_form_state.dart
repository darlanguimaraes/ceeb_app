// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'book_form_state.g.dart';

@match
enum BookFormStatus {
  initial,
  loading,
  success,
  error,
}

class BookFormState extends Equatable {
  final BookFormStatus status;

  const BookFormState({
    required this.status,
  });

  const BookFormState.initial() : status = BookFormStatus.initial;

  @override
  List<Object> get props => [status];

  BookFormState copyWith({
    BookFormStatus? status,
  }) {
    return BookFormState(
      status: status ?? this.status,
    );
  }
}
