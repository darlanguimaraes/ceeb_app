// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension NoteListStatusMatch on NoteListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() updated,
      required T Function() error}) {
    final v = this;
    if (v == NoteListStatus.initial) {
      return initial();
    }

    if (v == NoteListStatus.loading) {
      return loading();
    }

    if (v == NoteListStatus.loaded) {
      return loaded();
    }

    if (v == NoteListStatus.updated) {
      return updated();
    }

    if (v == NoteListStatus.error) {
      return error();
    }

    throw Exception('NoteListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? updated,
      T Function()? error}) {
    final v = this;
    if (v == NoteListStatus.initial && initial != null) {
      return initial();
    }

    if (v == NoteListStatus.loading && loading != null) {
      return loading();
    }

    if (v == NoteListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == NoteListStatus.updated && updated != null) {
      return updated();
    }

    if (v == NoteListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
