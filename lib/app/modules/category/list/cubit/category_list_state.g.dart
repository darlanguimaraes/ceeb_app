// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CategoryListStatusMatch on CategoryListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == CategoryListStatus.initial) {
      return initial();
    }

    if (v == CategoryListStatus.loading) {
      return loading();
    }

    if (v == CategoryListStatus.loaded) {
      return loaded();
    }

    if (v == CategoryListStatus.error) {
      return error();
    }

    throw Exception(
        'CategoryListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == CategoryListStatus.initial && initial != null) {
      return initial();
    }

    if (v == CategoryListStatus.loading && loading != null) {
      return loading();
    }

    if (v == CategoryListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == CategoryListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
