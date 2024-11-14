// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/configuration/configuration_model.dart';

part 'configuration_state.g.dart';

@match
enum ConfigurationStatus {
  initial,
  loading,
  error,
  authError,
  success,
  authSuccess,
}

class ConfigurationState extends Equatable {
  final ConfigurationStatus status;
  final bool isAuth;
  final String error;
  final ConfigurationModel? configuration;

  const ConfigurationState({
    required this.status,
    required this.isAuth,
    required this.error,
    this.configuration,
  });

  const ConfigurationState.initial()
      : status = ConfigurationStatus.initial,
        isAuth = false,
        error = '',
        configuration = null;

  @override
  List<Object> get props => [status, isAuth, error];

  ConfigurationState copyWith({
    ConfigurationStatus? status,
    bool? isAuth,
    String? error,
    ConfigurationModel? configuration,
  }) {
    return ConfigurationState(
      status: status ?? this.status,
      isAuth: isAuth ?? this.isAuth,
      error: error ?? this.error,
      configuration: configuration ?? this.configuration,
    );
  }
}
