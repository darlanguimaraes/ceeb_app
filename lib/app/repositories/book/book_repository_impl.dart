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
      where =
          ' where lower(name)="%${filter.toLowerCase()}%" or lower(author)="%${filter.toLowerCase()}%" or lower(code)="%${filter.toLowerCase()}%"';
    }
    final results =
        await conn.rawQuery('select * from ${Constants.TABLE_BOOK} $where');
    final List<BookModel> books = results.map(
      (e) {
        final book = BookModel.fromMap(e);
        book.nameDiacritics = StringUtils.removeDiacritics(book.name);
        return book;
      },
    ).toList();
    books.sort((a, b) => a.nameDiacritics!.compareTo(b.nameDiacritics!));
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
    map.remove('created_at');
    await conn.update(
      Constants.TABLE_BOOK,
      map,
      where: 'id=?',
      whereArgs: [book.id],
    );
  }
}
