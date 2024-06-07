import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/repositories/invoice/invoice_repository.dart';

import './invoice_service.dart';

class InvoiceServiceImpl implements InvoiceService {
  final InvoiceRepository _invoiceRepository;

  InvoiceServiceImpl({required InvoiceRepository invoiceRepository})
      : _invoiceRepository = invoiceRepository;

  @override
  Future<List<InvoiceModel>> list() async {
    return await _invoiceRepository.list();
  }

  @override
  Future<void> save(InvoiceModel invoice) async {
    await _invoiceRepository.save(invoice);
  }
}
