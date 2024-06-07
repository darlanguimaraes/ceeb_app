import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/home/home_page.dart';
import 'package:provider/provider.dart';

class HomeModule extends CeebModule {
  HomeModule()
      : super(
          bindings: [
            Provider(create: (context) => Object()),
          ],
          router: {
            Constants.ROUTE_MENU: (context) => const HomePage(),
          },
        );
}
