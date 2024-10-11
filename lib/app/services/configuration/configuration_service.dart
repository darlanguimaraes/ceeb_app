import 'package:ceeb_app/app/models/configuration/configuration_model.dart';

abstract interface class ConfigurationService {
  Future<void> update(ConfigurationModel configuration);
  Future<ConfigurationModel> get();
}
