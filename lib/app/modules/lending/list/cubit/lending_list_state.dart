// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/lending/lending_model.dart';

part 'lending_list_state.g.dart';

@match
enum LendingListStatus {
  initial,
  loading,
  loaded,
  error,
  updated,
}

class LendingListState extends Equatable {
  final LendingListStatus status;
  final List<LendingModel> lendings;

  const LendingListState({required this.status, required this.lendings});

  LendingListState.initial()
      : status = LendingListStatus.initial,
        lendings = [];

  @override
  List<Object> get props => [status, lendings];

  LendingListState copyWith({
    LendingListStatus? status,
    List<LendingModel>? lendings,
  }) {
    return LendingListState(
      status: status ?? this.status,
      lendings: lendings ?? this.lendings,
    );
  }
}
