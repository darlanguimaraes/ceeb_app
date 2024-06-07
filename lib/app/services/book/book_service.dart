import 'package:ceeb_app/app/models/book/book_model.dart';

abstract interface class BookService {
  Future<void> save(BookModel book);
  Future<List<BookModel>> list(String? filter);
}
