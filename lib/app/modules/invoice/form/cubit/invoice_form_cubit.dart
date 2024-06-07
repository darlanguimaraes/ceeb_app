import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/modules/invoice/form/cubit/invoice_form_state.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service.dart';

class InvoiceFormCubit extends Cubit<InvoiceFormState> {
  final InvoiceService _invoiceService;
  final CategoryService _categoryService;

  InvoiceFormCubit(
    this._invoiceService,
    this._categoryService,
  ) : super(InvoiceFormState.initial());

  Future<void> save(InvoiceModel invoice) async {
    try {
      emit(state.copyWith(status: InvoiceFormStatus.loading));
      await _invoiceService.save(invoice);
      emit(state.copyWith(status: InvoiceFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: InvoiceFormStatus.error));
    }
  }

  Future<void> loadDependencies() async {
    try {
      emit(state.copyWith(status: InvoiceFormStatus.loading));
      final categories = await _categoryService.list();
      emit(state.copyWith(
        status: InvoiceFormStatus.loaded,
        categories: categories,
      ));
    } catch (e, s) {
      log('Erro ao carregar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: InvoiceFormStatus.error));
    }
  }

  CategoryModel? getCategorySelected(int id) {
    return state.categories.firstWhere(
      (element) => element.id == id,
    );
  }
}
