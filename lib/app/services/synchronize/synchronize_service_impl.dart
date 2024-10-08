import 'package:ceeb_app/app/repositories/synchronize/synchronize_repository.dart';

import './synchronize_service.dart';

class SynchronizeServiceImpl implements SynchronizeService {
  final SynchronizeRepository _synchronizeRepository;

  SynchronizeServiceImpl({required SynchronizeRepository synchronizeRepository})
      : _synchronizeRepository = synchronizeRepository;

  @override
  Future<void> synchronize() async {
    throw UnimplementedError();
  }
}
