// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/reader/reader_model.dart';

part 'reader_list_state.g.dart';

@match
enum ReaderListStatus {
  initial,
  loading,
  loaded,
  error,
}

class ReaderListState extends Equatable {
  final ReaderListStatus status;
  final List<ReaderModel> readers;

  const ReaderListState({
    required this.status,
    required this.readers,
  });

  ReaderListState.initial()
      : status = ReaderListStatus.initial,
        readers = [];

  @override
  List<Object> get props => [status, readers];

  ReaderListState copyWith({
    ReaderListStatus? status,
    List<ReaderModel>? readers,
  }) {
    return ReaderListState(
      status: status ?? this.status,
      readers: readers ?? this.readers,
    );
  }
}
