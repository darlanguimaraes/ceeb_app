// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/category/category_model.dart';

part 'invoice_form_state.g.dart';

@match
enum InvoiceFormStatus {
  initial,
  loading,
  loaded,
  success,
  changed,
  error,
}

class InvoiceFormState extends Equatable {
  final InvoiceFormStatus status;
  final List<CategoryModel> categories;
  final CategoryModel? category;
  final int quantity;
  final double total;
  final bool showQuantity;
  final bool disableTotal;

  const InvoiceFormState({
    required this.status,
    required this.categories,
    this.category,
    required this.quantity,
    required this.total,
    required this.showQuantity,
    required this.disableTotal,
  });
  InvoiceFormState.initial()
      : status = InvoiceFormStatus.initial,
        categories = [],
        category = null,
        quantity = 0,
        total = 0,
        showQuantity = false,
        disableTotal = false;

  @override
  List<Object> get props => [status, categories];

  InvoiceFormState copyWith({
    InvoiceFormStatus? status,
    List<CategoryModel>? categories,
    CategoryModel? category,
    int? quantity,
    double? total,
    bool? showQuantity,
    bool? disableTotal,
  }) {
    return InvoiceFormState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      showQuantity: showQuantity ?? this.showQuantity,
      disableTotal: disableTotal ?? this.disableTotal,
    );
  }
}
