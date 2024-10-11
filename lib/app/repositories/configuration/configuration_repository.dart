import 'package:ceeb_app/app/models/configuration/configuration_model.dart';

abstract interface class ConfigurationRepository {
  Future<void> update(ConfigurationModel configuration);
  Future<ConfigurationModel> get();
}
