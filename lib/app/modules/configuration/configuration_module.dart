import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/configuration/configuration_page.dart';
import 'package:ceeb_app/app/modules/configuration/cubit/configuration_cubit.dart';
import 'package:ceeb_app/app/repositories/configuration/configuration_repository.dart';
import 'package:ceeb_app/app/repositories/configuration/configuration_repository_impl.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service_impl.dart';
import 'package:provider/provider.dart';

class ConfigurationModule extends CeebModule {
  ConfigurationModule()
      : super(bindings: [
          Provider<ConfigurationRepository>(
              create: (context) => ConfigurationRepositoryImpl(
                  sqliteConnectionFactory: context.read())),
          Provider<ConfigurationService>(
              create: (context) => ConfigurationServiceImpl(
                  configurationRepository: context.read())),
          Provider(create: (context) => ConfigurationCubit(context.read())),
        ], router: {
          Constants.ROUTE_CONFIG: (context) => const ConfigurationPage(),
        });
}
