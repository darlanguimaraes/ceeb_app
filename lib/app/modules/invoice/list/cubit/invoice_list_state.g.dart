// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_list_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension InvoiceListStatusMatch on InvoiceListStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() error}) {
    final v = this;
    if (v == InvoiceListStatus.initial) {
      return initial();
    }

    if (v == InvoiceListStatus.loading) {
      return loading();
    }

    if (v == InvoiceListStatus.loaded) {
      return loaded();
    }

    if (v == InvoiceListStatus.error) {
      return error();
    }

    throw Exception(
        'InvoiceListStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? error}) {
    final v = this;
    if (v == InvoiceListStatus.initial && initial != null) {
      return initial();
    }

    if (v == InvoiceListStatus.loading && loading != null) {
      return loading();
    }

    if (v == InvoiceListStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == InvoiceListStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
