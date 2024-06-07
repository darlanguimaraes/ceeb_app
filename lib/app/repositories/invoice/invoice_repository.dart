import 'package:ceeb_app/app/models/invoice/invoice_model.dart';

abstract interface class InvoiceRepository {
  Future<void> save(InvoiceModel invoice);
  Future<List<InvoiceModel>> list();
}
