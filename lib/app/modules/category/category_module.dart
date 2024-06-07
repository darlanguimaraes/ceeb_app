import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/modules/category/form/category_form_page.dart';
import 'package:ceeb_app/app/modules/category/form/cubit/category_form_cubit.dart';
import 'package:ceeb_app/app/modules/category/list/category_list_page.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/category/list/cubit/category_list_cubit.dart';
import 'package:ceeb_app/app/repositories/category/category_repository.dart';
import 'package:ceeb_app/app/repositories/category/category_repository_impl.dart';
import 'package:ceeb_app/app/services/category/category_service.dart';
import 'package:ceeb_app/app/services/category/category_service_impl.dart';
import 'package:provider/provider.dart';

class CategoryModule extends CeebModule {
  CategoryModule()
      : super(
          bindings: [
            Provider<CategoryRepository>(
              create: (context) =>
                  CategoryRepositoryImpl(isarHelper: context.read()),
            ),
            Provider<CategoryService>(
              create: (context) => CategoryServiceImpl(context.read()),
            ),
            Provider(
              create: (context) => CategoryFormCubit(context.read()),
            ),
            Provider(
              create: (context) => CategoryListCubit(context.read()),
            ),
          ],
          router: {
            Constants.ROUTE_CATEGORY_LIST: (context) =>
                const CategoryListPage(),
            Constants.ROUTE_CATEGORY_FORM: (context) =>
                const CategoryFormPage(),
          },
        );
}
