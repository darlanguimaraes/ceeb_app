import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_cubit.dart';
import 'package:ceeb_app/app/modules/synchronize/synchronize_page.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';
import 'package:ceeb_app/app/repositories/book/book_repository_impl.dart';
import 'package:ceeb_app/app/repositories/category/category_repository.dart';
import 'package:ceeb_app/app/repositories/category/category_repository_impl.dart';
import 'package:ceeb_app/app/repositories/configuration/configuration_repository.dart';
import 'package:ceeb_app/app/repositories/configuration/configuration_repository_impl.dart';
import 'package:ceeb_app/app/repositories/invoice/invoice_repository.dart';
import 'package:ceeb_app/app/repositories/invoice/invoice_repository_impl.dart';
import 'package:ceeb_app/app/repositories/lending/lending_repository.dart';
import 'package:ceeb_app/app/repositories/lending/lending_repository_impl.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository_impl.dart';
import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository.dart';
import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository_impl.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/book/book_service_impl.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:ceeb_app/app/services/category/category_service_impl.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service_impl.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service_impl.dart';
import 'package:ceeb_app/app/services/lending/lending_service.dart';
import 'package:ceeb_app/app/services/lending/lending_service_impl.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service_impl.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service_impl.dart';
import 'package:provider/provider.dart';

class SynchronizeModule extends CeebModule {
  SynchronizeModule()
      : super(
          bindings: [
            Provider<ConfigurationRepository>(
                create: (context) => ConfigurationRepositoryImpl(
                    sqliteConnectionFactory: context.read())),
            Provider<ConfigurationService>(
                create: (context) => ConfigurationServiceImpl(
                    configurationRepository: context.read())),
            Provider<SynchronizeRepository>(
              create: (context) => SynchronizeRepositoryImpl(
                dio: context.read(),
              ),
            ),
            Provider<CategoryRepository>(
              create: (context) => CategoryRepositoryImpl(
                sqliteConnectionFactory: context.read(),
                dio: context.read(),
              ),
            ),
            Provider<CategoryService>(
              create: (context) => CategoryServiceImpl(context.read()),
            ),
            Provider<BookRepository>(
              create: (context) => BookRepositoryImpl(
                sqliteConnectionFactory: context.read(),
                dio: context.read(),
              ),
            ),
            Provider<BookService>(
              create: (context) =>
                  BookServiceImpl(bookRepository: context.read()),
            ),
            Provider<ReaderRepository>(
              create: (context) => ReaderRepositoryImpl(
                connectionFactory: context.read(),
                dio: context.read(),
              ),
            ),
            Provider<ReaderService>(
              create: (context) =>
                  ReaderServiceImpl(readerRepository: context.read()),
            ),
            Provider<InvoiceRepository>(
              create: (context) => InvoiceRepositoryImpl(
                sqliteConnectionFactory: context.read(),
                dio: context.read(),
              ),
            ),
            Provider<InvoiceService>(
              create: (context) =>
                  InvoiceServiceImpl(invoiceRepository: context.read()),
            ),
            Provider<LendingRepository>(
              create: (context) => LendingRepositoryImpl(
                sqliteConnectionFactory: context.read(),
                dio: context.read(),
              ),
            ),
            Provider<LendingService>(
              create: (context) => LendingServiceImpl(
                lendingRepository: context.read(),
                readerRepository: context.read(),
                bookRepository: context.read(),
              ),
            ),
            Provider<SynchronizeService>(
              create: (context) => SynchronizeServiceImpl(
                synchronizeRepository: context.read(),
                categoryService: context.read(),
                bookService: context.read(),
                readerService: context.read(),
                invoiceService: context.read(),
                lendingService: context.read(),
                configurationService: context.read(),
              ),
            ),
            Provider(create: (context) => SynchronizeCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_SYNC: (context) => const SynchronizePage(),
          },
        );
}
