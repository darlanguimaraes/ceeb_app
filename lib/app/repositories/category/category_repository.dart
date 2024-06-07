import 'package:ceeb_app/app/models/category/category_model.dart';

abstract interface class CategoryRepository {
  Future<void> save(CategoryModel category);
  Future<List<CategoryModel>> list();
}
