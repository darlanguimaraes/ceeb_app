import 'package:ceeb_app/app/core/database/isar_helper.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:isar/isar.dart';

import './invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final IsarHelper _isarHelper;

  InvoiceRepositoryImpl({required IsarHelper isarHelper})
      : _isarHelper = isarHelper;
  @override
  Future<List<InvoiceModel>> list() async {
    final isar = await _isarHelper.init();
    return await isar.invoiceModels.where().sortByDateDesc().findAll();
  }

  @override
  Future<void> save(InvoiceModel invoice) async {
    final isar = await _isarHelper.init();
    await isar.writeTxn(() async {
      await isar.invoiceModels.put(invoice);
    });
  }
}
