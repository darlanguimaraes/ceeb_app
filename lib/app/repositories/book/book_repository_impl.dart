import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:isar/isar.dart';

import './book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final IsarHelper isarHelper;

  BookRepositoryImpl({required this.isarHelper});

  @override
  Future<List<BookModel>> list(String? filter) async {
    final isar = await isarHelper.init();
    return await isar.bookModels.where().sortByName().findAll();
  }

  @override
  Future<void> save(BookModel book) async {
    final isar = await isarHelper.init();
    await isar.writeTxn(() async {
      await isar.bookModels.put(book);
    });
  }
}
