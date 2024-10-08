// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synchronize_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension SynchronizeStatusMatch on SynchronizeStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() error,
      required T Function() success}) {
    final v = this;
    if (v == SynchronizeStatus.initial) {
      return initial();
    }

    if (v == SynchronizeStatus.loading) {
      return loading();
    }

    if (v == SynchronizeStatus.error) {
      return error();
    }

    if (v == SynchronizeStatus.success) {
      return success();
    }

    throw Exception(
        'SynchronizeStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? error,
      T Function()? success}) {
    final v = this;
    if (v == SynchronizeStatus.initial && initial != null) {
      return initial();
    }

    if (v == SynchronizeStatus.loading && loading != null) {
      return loading();
    }

    if (v == SynchronizeStatus.error && error != null) {
      return error();
    }

    if (v == SynchronizeStatus.success && success != null) {
      return success();
    }

    return any();
  }
}
