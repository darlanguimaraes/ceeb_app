import 'package:ceeb_app/app/models/lending/lending_model.dart';

abstract interface class LendingRepository {
  Future<void> save(LendingModel lending);
  Future<void> update(LendingModel lending);
  Future<LendingModel> get(int id);
  Future<List<LendingModel>> list(String? filter, bool? returned);
  Future<void> renewLending(int id, DateTime expectedDate);
  Future<void> returnLending(int id);
}
