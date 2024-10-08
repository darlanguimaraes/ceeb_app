import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/leading/form/cubit/leading_form_cubit.dart';
import 'package:ceeb_app/app/modules/leading/form/leading_form_page.dart';
import 'package:ceeb_app/app/modules/leading/list/cubit/leading_list_cubit.dart';
import 'package:ceeb_app/app/modules/leading/list/leading_list_page.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';
import 'package:ceeb_app/app/repositories/book/book_repository_impl.dart';
import 'package:ceeb_app/app/repositories/leading/leading_repository.dart';
import 'package:ceeb_app/app/repositories/leading/leading_repository_impl.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository_impl.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/book/book_service_impl.dart';
import 'package:ceeb_app/app/services/leading/leading_service.dart';
import 'package:ceeb_app/app/services/leading/leading_service_impl.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service_impl.dart';
import 'package:provider/provider.dart';

class LeadingModule extends CeebModule {
  LeadingModule()
      : super(
          bindings: [
            Provider<LeadingRepository>(
              create: (context) => LeadingRepositoryImpl(
                  sqliteConnectionFactory: context.read()),
            ),
            Provider<LeadingService>(
              create: (context) =>
                  LeadingServiceImpl(leadingRepository: context.read()),
            ),
            Provider<ReaderRepository>(
              create: (context) =>
                  ReaderRepositoryImpl(connectionFactory: context.read()),
            ),
            Provider<ReaderService>(
              create: (context) =>
                  ReaderServiceImpl(readerRepository: context.read()),
            ),
            Provider<BookRepository>(
              create: (context) =>
                  BookRepositoryImpl(sqliteConnectionFactory: context.read()),
            ),
            Provider<BookService>(
              create: (context) =>
                  BookServiceImpl(bookRepository: context.read()),
            ),
            Provider(
              create: (context) => LeadingFormCubit(
                context.read(),
                context.read(),
                context.read(),
              ),
            ),
            Provider(create: (context) => LeadingListCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_LEADING_FORM: (context) => const LeadingFormPage(),
            Constants.ROUTE_LEADING_LIST: (context) => const LeadingListPage(),
          },
        );
}
