import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/reader/form/cubit/reader_form_cubit.dart';
import 'package:ceeb_app/app/modules/reader/form/reader_form_page.dart';
import 'package:ceeb_app/app/modules/reader/list/cubit/reader_list_cubit.dart';
import 'package:ceeb_app/app/modules/reader/list/reader_list_page.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository_impl.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';
import 'package:ceeb_app/app/services/reader/reader_service_impl.dart';
import 'package:provider/provider.dart';

class ReaderModule extends CeebModule {
  ReaderModule()
      : super(
          bindings: [
            Provider<ReaderRepository>(
              create: (context) =>
                  ReaderRepositoryImpl(isarHelper: context.read()),
            ),
            Provider<ReaderService>(
              create: (context) =>
                  ReaderServiceImpl(readerRepository: context.read()),
            ),
            Provider(create: (context) => ReaderListCubit(context.read())),
            Provider(create: (context) => ReaderFormCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_READER_LIST: (context) => const ReaderListPage(),
            Constants.ROUTE_READER_FORM: (context) => const ReaderFormPage(),
          },
        );
}
