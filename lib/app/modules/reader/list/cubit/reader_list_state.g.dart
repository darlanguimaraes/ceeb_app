// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension ReaderListStatusMatch on ReaderListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == ReaderListStatus.initial) {
      return initial();
    }

    if (v == ReaderListStatus.loading) {
      return loading();
    }

    if (v == ReaderListStatus.loaded) {
      return loaded();
    }

    if (v == ReaderListStatus.error) {
      return error();
    }

    throw Exception('ReaderListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == ReaderListStatus.initial && initial != null) {
      return initial();
    }

    if (v == ReaderListStatus.loading && loading != null) {
      return loading();
    }

    if (v == ReaderListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == ReaderListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
