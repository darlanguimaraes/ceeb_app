// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:ceeb_app/app/models/category/category_model.dart';

part 'category_list_state.g.dart';

@match
enum CategoryListStatus {
  initial,
  loading,
  loaded,
  error,
}

class CategoryListState extends Equatable {
  final CategoryListStatus status;
  final List<CategoryModel> categories;

  const CategoryListState({
    required this.status,
    required this.categories,
  });

  CategoryListState.initial()
      : status = CategoryListStatus.initial,
        categories = [];

  @override
  List<Object> get props => [status, categories];

  CategoryListState copyWith({
    CategoryListStatus? status,
    List<CategoryModel>? categories,
  }) {
    return CategoryListState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }
}
