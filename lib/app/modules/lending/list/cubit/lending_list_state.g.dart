// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lending_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension LendingListStatusMatch on LendingListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error,
      required T Function() updated}) {
    final v = this;
    if (v == LendingListStatus.initial) {
      return initial();
    }

    if (v == LendingListStatus.loading) {
      return loading();
    }

    if (v == LendingListStatus.loaded) {
      return loaded();
    }

    if (v == LendingListStatus.error) {
      return error();
    }

    if (v == LendingListStatus.updated) {
      return updated();
    }

    throw Exception(
        'LendingListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error,
      T Function()? updated}) {
    final v = this;
    if (v == LendingListStatus.initial && initial != null) {
      return initial();
    }

    if (v == LendingListStatus.loading && loading != null) {
      return loading();
    }

    if (v == LendingListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == LendingListStatus.error && error != null) {
      return error();
    }

    if (v == LendingListStatus.updated && updated != null) {
      return updated();
    }

    return any();
  }
}
