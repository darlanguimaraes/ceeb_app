// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension BookFormStatusMatch on BookFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == BookFormStatus.initial) {
      return initial();
    }

    if (v == BookFormStatus.loading) {
      return loading();
    }

    if (v == BookFormStatus.success) {
      return success();
    }

    if (v == BookFormStatus.error) {
      return error();
    }

    throw Exception('BookFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == BookFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == BookFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == BookFormStatus.success && success != null) {
      return success();
    }

    if (v == BookFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
