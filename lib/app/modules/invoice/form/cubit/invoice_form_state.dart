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

  const InvoiceFormState({
    required this.status,
    required this.categories,
  });
  InvoiceFormState.initial()
      : status = InvoiceFormStatus.initial,
        categories = [];

  @override
  List<Object> get props => [status, categories];

  InvoiceFormState copyWith({
    InvoiceFormStatus? status,
    List<CategoryModel>? categories,
    int? category,
    bool? isMoney,
  }) {
    return InvoiceFormState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
