import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:isar/isar.dart';

import './reader_repository.dart';

class ReaderRepositoryImpl implements ReaderRepository {
  final IsarHelper _isarHelper;

  ReaderRepositoryImpl({required IsarHelper isarHelper})
      : _isarHelper = isarHelper;

  @override
  Future<List<ReaderModel>> list(String? filter) async {
    final isar = await _isarHelper.init();
    return await isar.readerModels.where().sortByName().findAll();
  }

  @override
  Future<void> save(ReaderModel reader) async {
    final isar = await _isarHelper.init();
    await isar.writeTxn(() async {
      await isar.readerModels.put(reader);
    });
  }
}
