import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/reader/list/cubit/reader_list_state.dart';
import 'package:ceeb_app/app/services/reader/reader_service.dart';

class ReaderListCubit extends Cubit<ReaderListState> {
  final ReaderService _readerService;

  ReaderListCubit(this._readerService) : super(ReaderListState.initial());

  Future<void> list(String? filter) async {
    try {
      emit(state.copyWith(status: ReaderListStatus.loading));
      final readers = await _readerService.list(filter);
      emit(state.copyWith(
        status: ReaderListStatus.loaded,
        readers: readers,
      ));
    } catch (e, s) {
      log('Erro ao listar os dados', error: e, stackTrace: s);
      emit(state.copyWith(status: ReaderListStatus.error));
    }
  }
}
