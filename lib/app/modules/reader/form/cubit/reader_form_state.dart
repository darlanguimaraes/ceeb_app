// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'reader_form_state.g.dart';

@match
enum ReaderFormStatus {
  initial,
  loading,
  success,
  error,
}

class ReaderFormState extends Equatable {
  final ReaderFormStatus status;

  const ReaderFormState({
    required this.status,
  });

  const ReaderFormState.initial() : status = ReaderFormStatus.initial;

  @override
  List<Object> get props => [status];

  ReaderFormState copyWith({
    ReaderFormStatus? status,
  }) {
    return ReaderFormState(
      status: status ?? this.status,
    );
  }
}
