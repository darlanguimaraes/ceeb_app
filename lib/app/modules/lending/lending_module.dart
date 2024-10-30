import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/lending/form/cubit/lending_form_cubit.dart';
import 'package:ceeb_app/app/modules/lending/form/lending_form_page.dart';
import 'package:ceeb_app/app/modules/lending/list/cubit/lending_list_cubit.dart';
import 'package:ceeb_app/app/modules/lending/list/lending_list_page.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';
import 'package:ceeb_app/app/repositories/book/book_repository_impl.dart';
import 'package:ceeb_app/app/repositories/lending/lending_repository.dart';
import 'package:ceeb_app/app/repositories/lending/lending_repository_impl.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository_impl.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/book/book_service_impl.dart';
import 'package:ceeb_app/app/services/lending/lending_service.dart';
import 'package:ceeb_app/app/services/lending/lending_service_impl.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service_impl.dart';
import 'package:provider/provider.dart';

class LendingModule extends CeebModule {
  LendingModule()
      : super(
          bindings: [
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
            Provider(
              create: (context) => LendingFormCubit(
                context.read(),
                context.read(),
                context.read(),
              ),
            ),
            Provider(create: (context) => LendingListCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_LENDING_FORM: (context) => const LendingFormPage(),
            Constants.ROUTE_LENDING_LIST: (context) => const LendingListPage(),
          },
        );
}
