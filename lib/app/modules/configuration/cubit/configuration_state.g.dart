// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ConfigurationStatusMatch on ConfigurationStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() error,
      required T Function() authError,
      required T Function() success}) {
    final v = this;
    if (v == ConfigurationStatus.initial) {
      return initial();
    }

    if (v == ConfigurationStatus.loading) {
      return loading();
    }

    if (v == ConfigurationStatus.error) {
      return error();
    }

    if (v == ConfigurationStatus.authError) {
      return authError();
    }

    if (v == ConfigurationStatus.success) {
      return success();
    }

    throw Exception(
        'ConfigurationStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? error,
      T Function()? authError,
      T Function()? success}) {
    final v = this;
    if (v == ConfigurationStatus.initial && initial != null) {
      return initial();
    }

    if (v == ConfigurationStatus.loading && loading != null) {
      return loading();
    }

    if (v == ConfigurationStatus.error && error != null) {
      return error();
    }

    if (v == ConfigurationStatus.authError && authError != null) {
      return authError();
    }

    if (v == ConfigurationStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
