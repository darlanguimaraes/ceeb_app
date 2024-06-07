import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:isar/isar.dart';

import './leading_repository.dart';

class LeadingRepositoryImpl implements LeadingRepository {
  final IsarHelper _isarHelper;

  LeadingRepositoryImpl({required IsarHelper isarHelper})
      : _isarHelper = isarHelper;

  @override
  Future<List<LeadingModel>> list(String? filter) async {
    final isar = await _isarHelper.init();
    return await isar.leadingModels.where().sortByDateDesc().findAll();
  }

  @override
  Future<void> save(LeadingModel leading) async {
    final isar = await _isarHelper.init();
    await isar.writeTxn(() async {
      await isar.leadingModels.put(leading);
    });
  }
}
