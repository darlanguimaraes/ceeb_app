// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leading_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LeadingFormStatusMatch on LeadingFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == LeadingFormStatus.initial) {
      return initial();
    }

    if (v == LeadingFormStatus.loading) {
      return loading();
    }

    if (v == LeadingFormStatus.loaded) {
      return loaded();
    }

    if (v == LeadingFormStatus.success) {
      return success();
    }

    if (v == LeadingFormStatus.error) {
      return error();
    }

    throw Exception(
        'LeadingFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == LeadingFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == LeadingFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == LeadingFormStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LeadingFormStatus.success && success != null) {
      return success();
    }

    if (v == LeadingFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
