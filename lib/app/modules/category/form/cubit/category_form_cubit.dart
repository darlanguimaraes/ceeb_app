import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/modules/category/form/cubit/category_form_state.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';

class CategoryFormCubit extends Cubit<CategoryFormState> {
  final CategoryService _categoryService;

  CategoryFormCubit(this._categoryService)
      : super(const CategoryFormState.initial());

  Future<void> save(CategoryModel category) async {
    category.sync = false;
    try {
      emit(state.copyWith(status: CategoryFormStatus.loading));
      if (category.id != null) {
        await _categoryService.update(category);
      } else {
        await _categoryService.save(category);
      }
      emit(state.copyWith(status: CategoryFormStatus.success));
    } catch (e, s) {
      log('Erro ao salvar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: CategoryFormStatus.error));
    }
  }

  void changeQuantityFixed(bool isFixed) {
    emit(state.copyWith(fixedQuantity: isFixed));
  }

  void changePriceFixed(bool isFixed) {
    emit(state.copyWith(fixedPrice: isFixed));
  }
}
