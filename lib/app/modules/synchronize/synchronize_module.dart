import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/module/ceeb_module.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_cubit.dart';
import 'package:ceeb_app/app/modules/synchronize/synchronize_page.dart';
import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository.dart';
import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository_impl.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service_impl.dart';
import 'package:provider/provider.dart';

class SynchronizeModule extends CeebModule {
  SynchronizeModule()
      : super(
          bindings: [
            Provider<SynchronizeRepository>(
              create: (context) => SynchronizeRepositoryImpl(
                sqliteConnectionFactory: context.read(),
              ),
            ),
            Provider<SynchronizeService>(
              create: (context) =>
                  SynchronizeServiceImpl(synchronizeRepository: context.read()),
            ),
            Provider(create: (context) => SynchronizeCubit(context.read())),
          ],
          router: {
            Constants.ROUTE_SYNC: (context) => const SynchronizePage(),
          },
        );
}
