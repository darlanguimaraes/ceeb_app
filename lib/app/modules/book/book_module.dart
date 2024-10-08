import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/book/form/book_form_page.dart';
import 'package:ceeb_app/app/modules/book/form/cubit/book_form_cubit.dart';
import 'package:ceeb_app/app/modules/book/list/book_list_page.dart';
import 'package:ceeb_app/app/modules/book/list/cubit/book_list_cubit.dart';
import 'package:ceeb_app/app/repositories/book/book_repository.dart';
import 'package:ceeb_app/app/repositories/book/book_repository_impl.dart';
import 'package:ceeb_app/app/services/book/book_service.dart';
import 'package:ceeb_app/app/services/book/book_service_impl.dart';
import 'package:provider/provider.dart';

class BookModule extends CeebModule {
  BookModule()
      : super(
          bindings: [
            Provider<BookRepository>(
              create: (context) =>
                  BookRepositoryImpl(sqliteConnectionFactory: context.read()),
            ),
            Provider<BookService>(
              create: (context) =>
                  BookServiceImpl(bookRepository: context.read()),
            ),
            Provider(create: (context) => BookListCubit(context.read())),
            Provider(create: (context) => BookFormCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_BOOK_LIST: (context) => const BookListPage(),
            Constants.ROUTE_BOOK_FORM: (context) => const BookFormPage(),
          },
        );
}
