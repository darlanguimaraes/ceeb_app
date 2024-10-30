import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/exceptions/repository_exception.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/string_utils.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/models/sync/book_sync_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

import './book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  final DioRestClient _dio;

  BookRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    required DioRestClient dio,
  })  : _sqliteConnectionFactory = sqliteConnectionFactory,
        _dio = dio;

  @override
  Future<List<BookModel>> list(String? filter) async {
    final conn = await _sqliteConnectionFactory.openConnection();

    var where = '';
    if (filter != null && filter != '') {
      final strFilter = StringUtils.removeDiacritics(filter).toLowerCase();
      where =
          ' where name_diacritics like "%$strFilter%" or lower(author) like "%$strFilter%" or lower(code) like "%$filter%"';
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
  Future<BookModel> get(int id) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final book = await conn
        .rawQuery('select * from ${Constants.TABLE_BOOK} where id=?', [id]);
    if (book.isNotEmpty) {
      return BookModel.fromMap(book[0]);
    }
    throw RepositoryException('Livro não encontrado');
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

  @override
  Future<void> sendData(String token) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await conn.query(
      Constants.TABLE_BOOK,
      where: 'sync=?',
      whereArgs: [0],
    );
    if (results.isNotEmpty) {
      final List<BookModel> books =
          results.map((e) => BookModel.fromMap(e)).toList();
      final response = await _dio.post(
        '${const String.fromEnvironment('backend_url')}sync/books',
        data: books.map((e) => e.toJson()).toList(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = response.data["data"];
      final List<BookSyncModel> registers = [];
      for (final register in data) {
        registers.add(BookSyncModel.fromMap(register));
      }
      if (registers.isNotEmpty) {
        for (final register in registers) {
          final data = {
            "sync": 1,
            "remote_id": register.id,
          };
          await conn.update(
            Constants.TABLE_BOOK,
            data,
            where: "id=?",
            whereArgs: [register.mobileId],
          );
        }
      }
    }
  }

  @override
  Future<SyncModel> receiveData(String token, DateTime date) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await _dio.get(
      '${const String.fromEnvironment('backend_url')}sync/books?date=${date.toIso8601String()}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = results.data['data'];
    for (final register in data) {
      final bookSync = BookSyncModel.fromMap(register);
      final bookRemote = await conn.query(
        Constants.TABLE_BOOK,
        where: 'remote_id=?',
        whereArgs: [bookSync.id],
      );
      final book = BookModel(
        id: bookSync.mobileId,
        name: bookSync.name,
        sync: true,
        author: bookSync.author,
        borrow: bookSync.borrow,
        code: bookSync.code,
        remoteId: bookSync.id,
        writer: bookSync.writer,
        nameDiacritics:
            StringUtils.removeDiacritics(bookSync.name).toLowerCase(),
      );
      if (bookRemote.isEmpty) {
        await conn.insert(
          Constants.TABLE_BOOK,
          book.toMap(),
        );
      } else {
        await conn.update(
          Constants.TABLE_BOOK,
          book.toMap(),
          where: 'id=?',
          whereArgs: [bookSync.mobileId],
        );
      }
    }
    return SyncModel(created: 1, updated: 1);
  }
}
