// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_form_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension InvoiceFormStatusMatch on InvoiceFormStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() changed,
      required T Function() error}) {
    final v = this;
    if (v == InvoiceFormStatus.initial) {
      return initial();
    }

    if (v == InvoiceFormStatus.loading) {
      return loading();
    }

    if (v == InvoiceFormStatus.loaded) {
      return loaded();
    }

    if (v == InvoiceFormStatus.success) {
      return success();
    }

    if (v == InvoiceFormStatus.changed) {
      return changed();
    }

    if (v == InvoiceFormStatus.error) {
      return error();
    }

    throw Exception(
        'InvoiceFormStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? changed,
      T Function()? error}) {
    final v = this;
    if (v == InvoiceFormStatus.initial && initial != null) {
      return initial();
    }

    if (v == InvoiceFormStatus.loading && loading != null) {
      return loading();
    }

    if (v == InvoiceFormStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == InvoiceFormStatus.success && success != null) {
      return success();
    }

    if (v == InvoiceFormStatus.changed && changed != null) {
      return changed();
    }

    if (v == InvoiceFormStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
