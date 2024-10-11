import 'package:ceeb_app/app/models/book/book_model.dart';

abstract interface class BookRepository {
  Future<void> save(BookModel book);
  Future<void> update(BookModel book);
  Future<List<BookModel>> list(String? filter);
  Future<void> borrowBook(int id, bool borrow);
}
