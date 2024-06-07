// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ReaderFormStatusMatch on ReaderFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == ReaderFormStatus.initial) {
      return initial();
    }

    if (v == ReaderFormStatus.loading) {
      return loading();
    }

    if (v == ReaderFormStatus.success) {
      return success();
    }

    if (v == ReaderFormStatus.error) {
      return error();
    }

    throw Exception('ReaderFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == ReaderFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == ReaderFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == ReaderFormStatus.success && success != null) {
      return success();
    }

    if (v == ReaderFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
