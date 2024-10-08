import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/repositories/leading/leading_repository.dart';

import './leading_service.dart';

class LeadingServiceImpl implements LeadingService {
  final LeadingRepository _leadingRepository;

  LeadingServiceImpl({required LeadingRepository leadingRepository})
      : _leadingRepository = leadingRepository;

  @override
  Future<List<LeadingModel>> list(String? filter, bool? returned) async {
    return await _leadingRepository.list(filter, returned);
  }

  @override
  Future<void> save(LeadingModel leading) async {
    await _leadingRepository.save(leading);
  }

  @override
  Future<void> update(LeadingModel leading) async {
    await _leadingRepository.update(leading);
  }
}
