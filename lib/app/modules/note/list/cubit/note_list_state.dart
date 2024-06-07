// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/node/note_model.dart';

part 'note_list_state.g.dart';

@match
enum NoteListStatus {
  initial,
  loading,
  loaded,
  error,
}

class NoteListState extends Equatable {
  final NoteListStatus status;
  final List<NoteModel> notes;

  const NoteListState({
    required this.status,
    required this.notes,
  });

  NoteListState.initial()
      : status = NoteListStatus.initial,
        notes = [];

  @override
  List<Object> get props => [status, notes];

  NoteListState copyWith({
    NoteListStatus? status,
    List<NoteModel>? notes,
  }) {
    return NoteListState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
