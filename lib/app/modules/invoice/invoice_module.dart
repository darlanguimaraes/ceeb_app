import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/invoice/form/cubit/invoice_form_cubit.dart';
import 'package:ceeb_app/app/modules/invoice/form/invoice_form_page.dart';
import 'package:ceeb_app/app/modules/invoice/list/cubit/invoice_list_cubit.dart';
import 'package:ceeb_app/app/modules/invoice/list/invoice_list_page.dart';
import 'package:ceeb_app/app/repositories/category/category_repository.dart';
import 'package:ceeb_app/app/repositories/category/category_repository_impl.dart';
import 'package:ceeb_app/app/repositories/invoice/invoice_repository.dart';
import 'package:ceeb_app/app/repositories/invoice/invoice_repository_impl.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:ceeb_app/app/services/category/category_service_impl.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service.dart';
import 'package:ceeb_app/app/services/invoice/invoice_service_impl.dart';
import 'package:provider/provider.dart';

class InvoiceModule extends CeebModule {
  InvoiceModule()
      : super(
          bindings: [
            Provider<InvoiceRepository>(
              create: (context) =>
                  InvoiceRepositoryImpl(isarHelper: context.read()),
            ),
            Provider<InvoiceService>(
              create: (context) =>
                  InvoiceServiceImpl(invoiceRepository: context.read()),
            ),
            Provider<CategoryRepository>(
              create: (context) =>
                  CategoryRepositoryImpl(isarHelper: context.read()),
            ),
            Provider<CategoryService>(
              create: (context) => CategoryServiceImpl(context.read()),
            ),
            Provider(create: (context) => InvoiceListCubit(context.read())),
            Provider(
              create: (context) => InvoiceFormCubit(
                context.read(),
                context.read(),
              ),
            ),
          ],
          router: {
            Constants.ROUTE_INVOICE_LIST: (context) => const InvoiceListPage(),
            Constants.ROUTE_INVOICE_FORM: (context) => const InvoiceFormPage(),
          },
        );
}
