import 'package:bloc/bloc.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_state.dart';
import 'package:ceeb_app/app/services/synchronize/synchronize_service.dart';

class SynchronizeCubit extends Cubit<SynchronizeState> {
  final SynchronizeService _synchronizeService;

  SynchronizeCubit(this._synchronizeService)
      : super(
          const SynchronizeState.initial(),
        );
}
