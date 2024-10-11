// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lending_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LendingFormStatusMatch on LendingFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == LendingFormStatus.initial) {
      return initial();
    }

    if (v == LendingFormStatus.loading) {
      return loading();
    }

    if (v == LendingFormStatus.loaded) {
      return loaded();
    }

    if (v == LendingFormStatus.success) {
      return success();
    }

    if (v == LendingFormStatus.error) {
      return error();
    }

    throw Exception(
        'LendingFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == LendingFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == LendingFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == LendingFormStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LendingFormStatus.success && success != null) {
      return success();
    }

    if (v == LendingFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
