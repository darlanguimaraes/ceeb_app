import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/modules/category/form/cubit/category_form_state.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:isar/isar.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final CategoryService _categoryService;

  CategoryFormCubit(this._categoryService)
      : super(const CategoryFormState.initial());

  Future<void> save(Id? id, String name, double price) async {
    final category = CategoryModel(
      id: id,
      name: name,
      price: price,
      sync: false,
    );
    try {
      emit(state.copyWith(status: CategoryFormStatus.loading));
      await _categoryService.save(category);
      emit(state.copyWith(status: CategoryFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: CategoryFormStatus.error));
    }
  }
}
