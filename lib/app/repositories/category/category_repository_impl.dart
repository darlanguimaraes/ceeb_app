import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:isar/isar.dart';

import './category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final IsarHelper isarHelper;

  CategoryRepositoryImpl({required this.isarHelper});

  @override
  Future<List<CategoryModel>> list() async {
    final isar = await isarHelper.init();
    final categories = await isar.categoryModels.where().sortByName().findAll();
    return categories;
  }

  @override
  Future<void> save(CategoryModel category) async {
    final isar = await isarHelper.init();
    await isar.writeTxn(() async {
      await isar.categoryModels.put(category);
    });
  }
}
