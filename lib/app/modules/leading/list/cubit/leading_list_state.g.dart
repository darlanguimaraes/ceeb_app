// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leading_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LeadingListStatusMatch on LeadingListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == LeadingListStatus.initial) {
      return initial();
    }

    if (v == LeadingListStatus.loading) {
      return loading();
    }

    if (v == LeadingListStatus.loaded) {
      return loaded();
    }

    if (v == LeadingListStatus.error) {
      return error();
    }

    throw Exception(
        'LeadingListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == LeadingListStatus.initial && initial != null) {
      return initial();
    }

    if (v == LeadingListStatus.loading && loading != null) {
      return loading();
    }

    if (v == LeadingListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LeadingListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
