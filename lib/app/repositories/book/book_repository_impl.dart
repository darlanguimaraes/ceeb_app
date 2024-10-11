import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/string_utils.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';

import './book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  BookRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<BookModel>> list(String? filter) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    var where = '';
    if (filter != null) {
      final strFilter = StringUtils.removeDiacritics(filter).toLowerCase();
      where =
          ' where name_diacritics="%$strFilter%" or lower(author)="%$strFilter%" or lower(code)="%$filter%"';
    }
    final results = await conn.rawQuery(
        'select * from ${Constants.TABLE_BOOK} $where order by name_diacritics asc');
    final List<BookModel> books = results.map(
      (e) {
        final book = BookModel.fromMap(e);
        return book;
      },
    ).toList();
    return books;
  }

  @override
  Future<void> save(BookModel book) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.insert(Constants.TABLE_BOOK, book.toMap());
  }

  @override
  Future<void> update(BookModel book) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    final map = book.toMap();
    await conn.update(
      Constants.TABLE_BOOK,
      map,
      where: 'id=?',
      whereArgs: [book.id],
    );
  }

  @override
  Future<void> borrowBook(int id, bool borrow) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = {
      "borrow": borrow ? 1 : 0,
      "sync": 0,
    };
    await conn.update(
      Constants.TABLE_BOOK,
      map,
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
