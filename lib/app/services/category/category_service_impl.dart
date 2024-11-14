import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/repositories/category/category_repository.dart';

import './category_service.dart';

class CategoryServiceImpl implements CategoryService {
  final CategoryRepository _categoryRepository;

  CategoryServiceImpl(this._categoryRepository);

  @override
  Future<List<CategoryModel>> list(String? name) async {
    return await _categoryRepository.list(name);
  }

  @override
  Future<void> save(CategoryModel category) async {
    await _categoryRepository.save(category);
  }

  @override
  Future<void> update(CategoryModel category) async {
    await _categoryRepository.update(category);
  }

  @override
  Future<void> synchronize(String url, String token, DateTime date) async {
    await _categoryRepository.sendData(url, token);
    await _categoryRepository.receiveData(url, token, date);
  }
}
