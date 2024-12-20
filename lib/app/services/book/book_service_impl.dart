import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';

import './book_service.dart';

class BookServiceImpl implements BookService {
  final BookRepository _bookRepository;

  BookServiceImpl({required BookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<List<BookModel>> list(String? filter) async {
    return await _bookRepository.list(filter);
  }

  @override
  Future<void> save(BookModel book) async {
    await _bookRepository.save(book);
  }

  @override
  Future<void> update(BookModel book) async {
    await _bookRepository.update(book);
  }

  @override
  Future<BookModel> get(int id) async {
    return await _bookRepository.get(id);
  }

  @override
  Future<void> synchronize(String url, String token, DateTime date) async {
    await _bookRepository.sendData(url, token);
    await _bookRepository.receiveData(url, token, date);
  }
}
