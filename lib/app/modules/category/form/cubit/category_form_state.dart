// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'category_form_state.g.dart';

@match
enum CategoryFormStatus {
  initial,
  loading,
  success,
  error,
}

class CategoryFormState extends Equatable {
  final CategoryFormStatus status;
  final bool fixedQuantity;
  final bool fixedPrice;

  const CategoryFormState({
    required this.status,
    required this.fixedQuantity,
    required this.fixedPrice,
  });

  const CategoryFormState.initial()
      : status = CategoryFormStatus.initial,
        fixedQuantity = false,
        fixedPrice = false;

  @override
  List<Object?> get props => [
        status,
        fixedQuantity,
        fixedPrice,
      ];

  CategoryFormState copyWith({
    CategoryFormStatus? status,
    bool? fixedQuantity,
    bool? fixedPrice,
  }) {
    return CategoryFormState(
      status: status ?? this.status,
      fixedQuantity: fixedQuantity ?? this.fixedQuantity,
      fixedPrice: fixedPrice ?? this.fixedPrice,
    );
  }
}
