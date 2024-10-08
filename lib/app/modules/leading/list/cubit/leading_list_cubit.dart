import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/leading/list/cubit/leading_list_state.dart';
import 'package:ceeb_app/app/services/leading/leading_service.dart';

class LeadingListCubit extends Cubit<LeadingListState> {
  final LeadingService _leadingService;

  LeadingListCubit(this._leadingService) : super(LeadingListState.initial());

  Future<void> list(String? filter, bool? returned) async {
    try {
      emit(state.copyWith(status: LeadingListStatus.loading));
      final leadings = await _leadingService.list(filter, returned);
      emit(state.copyWith(
        status: LeadingListStatus.loaded,
        leadings: leadings,
      ));
    } catch (e, s) {
      log('Erro ao listar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: LeadingListStatus.error));
    }
  }
}
