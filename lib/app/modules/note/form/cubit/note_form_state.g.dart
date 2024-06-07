// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension NoteFormStatusMatch on NoteFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == NoteFormStatus.initial) {
      return initial();
    }

    if (v == NoteFormStatus.loading) {
      return loading();
    }

    if (v == NoteFormStatus.success) {
      return success();
    }

    if (v == NoteFormStatus.error) {
      return error();
    }

    throw Exception('NoteFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == NoteFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == NoteFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == NoteFormStatus.success && success != null) {
      return success();
    }

    if (v == NoteFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
