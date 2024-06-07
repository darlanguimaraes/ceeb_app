// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/invoice/invoice_model.dart';

part 'invoice_list_state.g.dart';

@match
enum InvoiceListStatus {
  initial,
  loading,
  loaded,
  error,
}

class InvoiceListState extends Equatable {
  final InvoiceListStatus status;
  final List<InvoiceModel> invoices;

  const InvoiceListState({
    required this.status,
    required this.invoices,
  });

  InvoiceListState.initial()
      : status = InvoiceListStatus.initial,
        invoices = [];

  @override
  List<Object> get props => [status, invoices];

  InvoiceListState copyWith({
    InvoiceListStatus? status,
    List<InvoiceModel>? invoices,
  }) {
    return InvoiceListState(
      status: status ?? this.status,
      invoices: invoices ?? this.invoices,
    );
  }
}
