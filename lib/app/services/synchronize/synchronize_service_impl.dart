import 'dart:developer';

import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service.dart';
import 'package:ceeb_app/app/services/lending/lending_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';

import './synchronize_service.dart';

class SynchronizeServiceImpl implements SynchronizeService {
  final SynchronizeRepository _synchronizeRepository;
  final CategoryService _categoryService;
  final BookService _bookService;
  final ReaderService _readerService;
  final InvoiceService _invoiceService;
  final LendingService _lendingService;
  final ConfigurationService _configurationService;

  SynchronizeServiceImpl({
    required SynchronizeRepository synchronizeRepository,
    required CategoryService categoryService,
    required BookService bookService,
    required ReaderService readerService,
    required InvoiceService invoiceService,
    required LendingService lendingService,
    required ConfigurationService configurationService,
  })  : _synchronizeRepository = synchronizeRepository,
        _categoryService = categoryService,
        _bookService = bookService,
        _readerService = readerService,
        _invoiceService = invoiceService,
        _lendingService = lendingService,
        _configurationService = configurationService;

  @override
  Future<void> synchronize(String email, String password) async {
    try {
      final configuration = await _configurationService.get();
      final url =
          configuration.url ?? const String.fromEnvironment('backend_url');
      final token = await _synchronizeRepository.login(url, email, password);

      if (token.isNotEmpty) {
        final actualDate = DateTime.now();

        await _categoryService.synchronize(url, token, configuration.syncDate);
        await _bookService.synchronize(url, token, configuration.syncDate);
        await _readerService.synchronize(url, token, configuration.syncDate);
        await _invoiceService.synchronize(url, token, configuration.syncDate);
        await _lendingService.synchronize(url, token, configuration.syncDate);

        configuration.syncDate = actualDate;
        await _configurationService.update(configuration);
      }
    } catch (e, s) {
      log('Erro ao sincronizar ${e.toString()}', error: e, stackTrace: s);
      rethrow;
    }
  }
}
