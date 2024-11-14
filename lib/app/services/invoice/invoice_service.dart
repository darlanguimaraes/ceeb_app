import 'package:ceeb_app/app/models/invoice/invoice_model.dart';

abstract interface class InvoiceService {
  Future<void> save(InvoiceModel invoice);
  Future<void> update(InvoiceModel invoice);
  Future<List<InvoiceModel>> list();
  Future<void> synchronize(String url, String token, DateTime date);
}
