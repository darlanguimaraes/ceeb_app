import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';
import 'package:ceeb_app/app/repositories/lending/lending_repository.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';

import 'lending_service.dart';

class LendingServiceImpl implements LendingService {
  final LendingRepository _lendingRepository;
  final ReaderRepository _readerRepository;
  final BookRepository _bookRepository;

  LendingServiceImpl({
    required LendingRepository lendingRepository,
    required ReaderRepository readerRepository,
    required BookRepository bookRepository,
  })  : _lendingRepository = lendingRepository,
        _readerRepository = readerRepository,
        _bookRepository = bookRepository;

  @override
  Future<List<LendingModel>> list(String? filter, bool? returned) async {
    return await _lendingRepository.list(filter, returned);
  }

  @override
  Future<void> save(LendingModel lending) async {
    await _lendingRepository.save(lending);
    await _readerRepository.borrowBook(lending.readerId, true);
    await _bookRepository.borrowBook(lending.bookId, true);
  }

  @override
  Future<void> update(LendingModel lending) async {
    await _lendingRepository.update(lending);
  }

  @override
  Future<void> renewLending(int id, DateTime expectedDate) async {
    await _lendingRepository.renewLending(id, expectedDate);
  }

  @override
  Future<void> returnLending(int id) async {
    await _lendingRepository.returnLending(id);
    final lending = await _lendingRepository.get(id);
    await _readerRepository.borrowBook(lending.readerId, false);
    await _bookRepository.borrowBook(lending.bookId, false);
  }
}
