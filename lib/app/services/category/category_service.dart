import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

abstract interface class CategoryService {
  Future<void> save(CategoryModel category);
  Future<void> update(CategoryModel category);
  Future<List<CategoryModel>> list(String? name);
  Future<SyncModel> synchronize(String token, DateTime date);
}
