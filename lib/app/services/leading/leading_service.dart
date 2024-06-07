import 'package:ceeb_app/app/models/lending/lending_model.dart';

abstract interface class LeadingService {
  Future<void> save(LeadingModel leading);
  Future<List<LeadingModel>> list(String? filter);
}
