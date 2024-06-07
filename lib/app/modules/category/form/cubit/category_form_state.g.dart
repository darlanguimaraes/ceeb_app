// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CategoryFormStatusMatch on CategoryFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == CategoryFormStatus.initial) {
      return initial();
    }

    if (v == CategoryFormStatus.loading) {
      return loading();
    }

    if (v == CategoryFormStatus.success) {
      return success();
    }

    if (v == CategoryFormStatus.error) {
      return error();
    }

    throw Exception(
        'CategoryFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == CategoryFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == CategoryFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == CategoryFormStatus.success && success != null) {
      return success();
    }

    if (v == CategoryFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
