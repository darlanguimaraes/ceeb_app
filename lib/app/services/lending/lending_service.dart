import 'package:ceeb_app/app/models/lending/lending_model.dart';

abstract interface class LendingService {
  Future<void> save(LendingModel lending);
  Future<void> update(LendingModel lending);
  Future<List<LendingModel>> list(String? filter, bool? returned);
  Future<void> renewLending(int id, DateTime expectedDate);
  Future<void> returnLending(int id);
  Future<void> synchronize(String url, String token, DateTime date);
}
