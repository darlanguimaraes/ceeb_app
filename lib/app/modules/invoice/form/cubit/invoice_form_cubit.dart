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
      if (invoice.id != null) {
        await _invoiceService.update(invoice);
      } else {
        await _invoiceService.save(invoice);
      }
      emit(state.copyWith(status: InvoiceFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: InvoiceFormStatus.error));
    }
  }

  Future<void> loadDependencies() async {
    try {
      emit(state.copyWith(status: InvoiceFormStatus.loading));
      final categories = await _categoryService.list(null);
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
    final category = state.categories.firstWhere(
      (element) => element.id == id,
    );

    return category;
  }

  void changeCategory(int id) {
    emit(state.copyWith(status: InvoiceFormStatus.loading));
    final index = state.categories.indexWhere(
      (element) => element.id == id,
    );

    if (index >= 0) {
      final category = state.categories[index];

      emit(state.copyWith(
        status: InvoiceFormStatus.changed,
        category: category,
        showQuantity: category.fixedPrice,
        disableTotal: category.fixedQuantity,
        quantity: 0,
        total: 0,
      ));
    } else {
      emit(state.copyWith(
        status: InvoiceFormStatus.changed,
        category: null,
        showQuantity: false,
        disableTotal: false,
        quantity: 0,
        total: 0,
      ));
    }
  }

  void changeQuantity(int quantity) {
    emit(state.copyWith(status: InvoiceFormStatus.loading));
    double totalValue = 0;
    if (quantity > 0) {
      totalValue = quantity * state.category!.price!;
    }
    emit(state.copyWith(
      status: InvoiceFormStatus.changed,
      total: totalValue,
      quantity: quantity,
    ));
  }

  void setUpdateData(InvoiceModel invoice) {
    emit(state.copyWith(status: InvoiceFormStatus.loading));
    emit(state.copyWith(
      status: InvoiceFormStatus.changed,
      quantity: invoice.quantity,
      total: invoice.value,
    ));
  }
}
