// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'synchronize_state.g.dart';

@match
enum SynchronizeStatus {
  initial,
  loading,
  error,
  success,
}

class SynchronizeState extends Equatable {
  final SynchronizeStatus status;
  final String message;

  const SynchronizeState({
    required this.status,
    required this.message,
  });

  const SynchronizeState.initial()
      : status = SynchronizeStatus.initial,
        message = '';

  @override
  List<Object> get props => [status, message];

  SynchronizeState copyWith({
    SynchronizeStatus? status,
    String? message,
  }) {
    return SynchronizeState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
