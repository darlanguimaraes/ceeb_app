import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

abstract interface class InvoiceRepository {
  Future<void> save(InvoiceModel invoice);
  Future<void> update(InvoiceModel invoice);
  Future<List<InvoiceModel>> list();
  Future<void> sendData(String url, String token);
  Future<SyncModel> receiveData(String url, String token, DateTime date);
}
