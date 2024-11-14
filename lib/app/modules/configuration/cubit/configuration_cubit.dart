import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/models/configuration/configuration_model.dart';
import 'package:ceeb_app/app/modules/configuration/cubit/configuration_state.dart';
import 'package:ceeb_app/app/services/configuration/configuration_service.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  final ConfigurationService _configurationService;

  ConfigurationCubit(this._configurationService)
      : super(const ConfigurationState.initial());

  Future<void> validateAuth(String password) async {
    emit(state.copyWith(
      status: ConfigurationStatus.loading,
      error: '',
    ));
    if (password == const String.fromEnvironment('password')) {
      final configuration = await _configurationService.get();

      emit(state.copyWith(
        status: ConfigurationStatus.authSuccess,
        isAuth: true,
        configuration: configuration,
      ));
    } else {
      emit(state.copyWith(
        status: ConfigurationStatus.authError,
        isAuth: false,
        error: 'Senha inválida',
      ));
    }
  }

  Future<void> updateURL(String url) async {
    emit(state.copyWith(
      status: ConfigurationStatus.loading,
      error: '',
    ));
    try {
      final configuration = ConfigurationModel(
        syncDate: state.configuration!.syncDate,
        id: state.configuration!.id,
        url: url,
      );
      await _configurationService.update(configuration);
      emit(state.copyWith(
        status: ConfigurationStatus.success,
        error: '',
      ));
    } catch (e, s) {
      log('Erro ao atualizar configuração', error: e, stackTrace: s);
      emit(state.copyWith(
        status: ConfigurationStatus.error,
        error: 'Erro ao atualizar a configuração',
      ));
    }
  }
}
