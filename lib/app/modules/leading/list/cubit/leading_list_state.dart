// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/lending/lending_model.dart';

part 'leading_list_state.g.dart';

@match
enum LeadingListStatus {
  initial,
  loading,
  loaded,
  error,
}

class LeadingListState extends Equatable {
  final LeadingListStatus status;
  final List<LeadingModel> leadings;

  const LeadingListState({required this.status, required this.leadings});

  LeadingListState.initial()
      : status = LeadingListStatus.initial,
        leadings = [];

  @override
  List<Object> get props => [status, leadings];

  LeadingListState copyWith({
    LeadingListStatus? status,
    List<LeadingModel>? leadings,
  }) {
    return LeadingListState(
      status: status ?? this.status,
      leadings: leadings ?? this.leadings,
    );
  }
}
