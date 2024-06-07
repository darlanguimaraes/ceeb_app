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

  const CategoryFormState({
    required this.status,
  });

  const CategoryFormState.initial() : status = CategoryFormStatus.initial;

  @override
  List<Object?> get props => [status];

  CategoryFormState copyWith({
    CategoryFormStatus? status,
  }) {
    return CategoryFormState(
      status: status ?? this.status,
    );
  }
}
