import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/category/list/cubit/category_list_state.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  final CategoryService _categoryService;

  CategoryListCubit(this._categoryService) : super(CategoryListState.initial());

  Future<void> list() async {
    try {
      emit(state.copyWith(status: CategoryListStatus.loading));
      final categories = await _categoryService.list();
      emit(state.copyWith(
        status: CategoryListStatus.loaded,
        categories: categories,
      ));
    } catch (e, s) {
      log('Erro ao listar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: CategoryListStatus.error));
    }
  }
}
