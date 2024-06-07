// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'note_form_state.g.dart';

@match
enum NoteFormStatus {
  initial,
  loading,
  success,
  error,
}

class NoteFormState extends Equatable {
  final NoteFormStatus status;

  const NoteFormState({required this.status});

  const NoteFormState.initial() : status = NoteFormStatus.initial;

  @override
  List<Object> get props => [status];

  NoteFormState copyWith({
    NoteFormStatus? status,
  }) {
    return NoteFormState(
      status: status ?? this.status,
    );
  }
}
