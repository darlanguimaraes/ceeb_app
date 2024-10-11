import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_state.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service.dart';

class SynchronizeCubit extends Cubit<SynchronizeState> {
  final SynchronizeService _synchronizeService;

  SynchronizeCubit(this._synchronizeService)
      : super(const SynchronizeState.initial());

  Future<void> sync(String email, String password) async {
    try {
      emit(state.copyWith(status: SynchronizeStatus.loading));
      final token = await _synchronizeService.synchronize(email, password);
      emit(state.copyWith(status: SynchronizeStatus.success));
    } catch (e, s) {
      log('Erro oa sincronizar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: SynchronizeStatus.error));
    }
  }
}
