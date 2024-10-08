import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/exceptions/repository_exception.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/string_utils.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';

import './category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  CategoryRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<CategoryModel>> list(String? name) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery(
        'select * from ${Constants.TABLE_CATEGORY} order by name_diacritics desc');
    final List<CategoryModel> categories =
        result.map((e) => CategoryModel.fromMap(e)).toList();
    // categories.sort(
    //   (a, b) => a.nameDiacritics!.compareTo(b.nameDiacritics!),
    // );
    return categories;
  }

  @override
  Future<CategoryModel> save(CategoryModel category) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    category.nameDiacritics =
        StringUtils.removeDiacritics(category.name).toLowerCase();

    final validateExists = await conn.rawQuery(
        'select * from ${Constants.TABLE_CATEGORY} where name=?',
        [category.name]);
    if (validateExists.isNotEmpty) {
      throw RepositoryException('Categoria ${category.name} já cadastrada');
    }

    final id = await conn.insert(Constants.TABLE_CATEGORY, category.toMap());
    return await get(id);
  }

  @override
  Future<CategoryModel> update(CategoryModel category) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    category.nameDiacritics =
        StringUtils.removeDiacritics(category.name).toLowerCase();

    final validateExists = await conn.rawQuery(
        'select * from ${Constants.TABLE_CATEGORY} where id != ${category.id} and name="${category.name}"');
    if (validateExists.isNotEmpty) {
      throw RepositoryException('Categoria ${category.name} já cadastrada');
    }

    await conn.update(
      Constants.TABLE_CATEGORY,
      category.toMap(),
      where: 'id=?',
      whereArgs: [category.id],
    );
    return await get(category.id!);
  }

  @override
  Future<CategoryModel> get(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final category = await conn
        .rawQuery('Select * from ${Constants.TABLE_CATEGORY} where id=?', [id]);
    if (category.isNotEmpty) {
      return CategoryModel.fromMap(category[0]);
    }
    throw RepositoryException('Categoria não encontrada');
  }

  @override
  Future<int> delete(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    return await conn
        .rawDelete('delete from ${Constants.TABLE_CATEGORY} where id=?', [id]);
  }
}
