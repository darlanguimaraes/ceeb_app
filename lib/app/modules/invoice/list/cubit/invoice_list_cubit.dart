import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/invoice/list/cubit/invoice_list_state.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service.dart';

class InvoiceListCubit extends Cubit<InvoiceListState> {
  final InvoiceService _invoiceService;

  InvoiceListCubit(this._invoiceService) : super(InvoiceListState.initial());

  Future<void> list() async {
    try {
      emit(state.copyWith(status: InvoiceListStatus.loading));
      final invoices = await _invoiceService.list();
      emit(state.copyWith(
        status: InvoiceListStatus.loaded,
        invoices: invoices,
      ));
    } catch (e, s) {
      log('Erro ao listar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: InvoiceListStatus.error));
    }
  }
}
