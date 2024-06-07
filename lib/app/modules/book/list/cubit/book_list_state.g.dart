// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension BookListStatusMatch on BookListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == BookListStatus.initial) {
      return initial();
    }

    if (v == BookListStatus.loading) {
      return loading();
    }

    if (v == BookListStatus.loaded) {
      return loaded();
    }

    if (v == BookListStatus.error) {
      return error();
    }

    throw Exception('BookListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == BookListStatus.initial && initial != null) {
      return initial();
    }

    if (v == BookListStatus.loading && loading != null) {
      return loading();
    }

    if (v == BookListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == BookListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
