import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';

import './invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  InvoiceRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<InvoiceModel>> list() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await conn.rawQuery('''
    select 
      i.id,
      i.date,
      i.quantity,
      i.price,
      i.value,
      i.credit,
      i.payment_type,
      i.sync,
      i.remote_id,
      c.id as category_id,
      c.name as category_name
    from ${Constants.TABLE_INVOICE} i
     inner join ${Constants.TABLE_CATEGORY} c on c.id=i.category_id
    order by i.date desc;
    ''');
    return results.map((e) => InvoiceModel.fromMap(e)).toList();
  }

  @override
  Future<void> save(InvoiceModel invoice) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    invoice.createdAt = DateTime.now();
    invoice.updatedAt = DateTime.now();
    await conn.insert(Constants.TABLE_INVOICE, invoice.toMap());
  }

  @override
  Future<void> update(InvoiceModel invoice) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    invoice.updatedAt = DateTime.now();
    final map = invoice.toMap();
    map.remove('created_at');
    await conn.update(
      Constants.TABLE_INVOICE,
      map,
      where: 'id=?',
      whereArgs: [invoice.id],
    );
  }
}
