import 'package:ceeb_app/app/models/configuration/configuration_model.dart';
import 'package:ceeb_app/app/repositories/configuration/configuration_repository.dart';

import './configuration_service.dart';

class ConfigurationServiceImpl implements ConfigurationService {
  final ConfigurationRepository _configurationRepository;

  ConfigurationServiceImpl(
      {required ConfigurationRepository configurationRepository})
      : _configurationRepository = configurationRepository;

  @override
  Future<ConfigurationModel> get() async {
    return await _configurationRepository.get();
  }

  @override
  Future<void> update(ConfigurationModel configuration) async {
    await _configurationRepository.update(configuration);
  }
}
