import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

abstract interface class CategoryRepository {
  Future<CategoryModel> save(CategoryModel category);
  Future<CategoryModel> update(CategoryModel category);
  Future<List<CategoryModel>> list(String? name);
  Future<CategoryModel> get(int id);
  Future<void> delete(int id);
  Future<void> sendData(String token);
  Future<SyncModel> receiveData(String token, DateTime date);
}
