import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/lending/list/cubit/lending_list_state.dart';
import 'package:ceeb_app/app/services/lending/lending_service.dart';

class LendingListCubit extends Cubit<LendingListState> {
  final LendingService _lendingService;

  LendingListCubit(this._lendingService) : super(LendingListState.initial());

  Future<void> list(String? filter, bool? returned) async {
    try {
      emit(state.copyWith(status: LendingListStatus.loading));
      final leadings = await _lendingService.list(filter, returned);
      emit(state.copyWith(
        status: LendingListStatus.loaded,
        lendings: leadings,
      ));
    } catch (e, s) {
      log('Erro ao listar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: LendingListStatus.error));
    }
  }

  Future<bool> renewLending(int id) async {
    try {
      emit(state.copyWith(status: LendingListStatus.loading));
      final expectedDate = DateTime.now().add(const Duration(days: 30));
      await _lendingService.renewLending(id, expectedDate);
      emit(state.copyWith(status: LendingListStatus.updated));
      return true;
    } catch (e, s) {
      log('Não foi possível completar a operação', error: e, stackTrace: s);
      emit(state.copyWith(status: LendingListStatus.error));
      return false;
    }
  }

  Future<bool> returnLending(int id) async {
    try {
      emit(state.copyWith(status: LendingListStatus.loading));
      await _lendingService.returnLending(id);
      emit(state.copyWith(status: LendingListStatus.updated));
      return true;
    } catch (e, s) {
      log('Não foi possível completar a operação', error: e, stackTrace: s);
      emit(state.copyWith(status: LendingListStatus.error));
      return false;
    }
  }
}
