import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/models/sync/invoice_sync_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';
import 'package:sqflite/sqflite.dart';

import './invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  final DioRestClient _dio;

  InvoiceRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    required DioRestClient dio,
  })  : _sqliteConnectionFactory = sqliteConnectionFactory,
        _dio = dio;

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
    await conn.insert(Constants.TABLE_INVOICE, invoice.toMap());
  }

  @override
  Future<void> update(InvoiceModel invoice) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final map = invoice.toMap();
    map.remove('created_at');
    await conn.update(
      Constants.TABLE_INVOICE,
      map,
      where: 'id=?',
      whereArgs: [invoice.id],
    );
  }

  @override
  Future<void> sendData(String url, String token) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await conn.rawQuery(
        '''select i.id, i.date, i.quantity, i.price, i.value, i.credit, i.payment_type, i.remote_id, c.remote_id as category_id
     from ${Constants.TABLE_INVOICE} i
     join ${Constants.TABLE_CATEGORY} c on c.id=i.category_id
     where i.sync=0''');
    if (results.isNotEmpty) {
      final response = await _dio.post(
        '${url}sync/invoices',
        data: results.toList(),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = response.data["data"];
      final List<InvoiceSyncModel> registers = [];
      for (final register in data) {
        registers.add(InvoiceSyncModel.fromMap(register));
      }
      if (registers.isNotEmpty) {
        for (final register in registers) {
          final data = {
            "sync": 1,
            "remote_id": register.id,
          };
          await conn.update(
            Constants.TABLE_INVOICE,
            data,
            where: "id=?",
            whereArgs: [register.mobileId],
          );
        }
      }
    }
  }

  @override
  Future<SyncModel> receiveData(String url, String token, DateTime date) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final results = await _dio.get(
      '${url}sync/invoices?date=${date.toIso8601String()}',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = results.data['data'];
    for (final register in data) {
      final invoiceSync = InvoiceSyncModel.fromMap(register);
      final invoiceRemote = await conn.query(
        Constants.TABLE_INVOICE,
        where: 'remote_id=?',
        whereArgs: [invoiceSync.id],
      );
      final categoryId = await findByRemoteId(
        conn,
        invoiceSync.categoryId,
        Constants.TABLE_CATEGORY,
      );

      final invoice = InvoiceModel(
        id: invoiceSync.mobileId,
        categoryId: categoryId,
        credit: invoiceSync.credit,
        date: invoiceSync.date,
        paymentType: invoiceSync.paymentType,
        price: invoiceSync.price.toDouble(),
        quantity: invoiceSync.quantity,
        value: invoiceSync.value.toDouble(),
        sync: true,
        remoteId: invoiceSync.id,
      );
      if (invoiceRemote.isEmpty) {
        await conn.insert(
          Constants.TABLE_INVOICE,
          invoice.toMap(),
        );
      } else {
        await conn.update(
          Constants.TABLE_INVOICE,
          invoice.toMap(),
          where: 'id=?',
          whereArgs: [invoiceSync.mobileId],
        );
      }
    }
    return SyncModel(created: 1, updated: 1);
  }

  Future<int> findByRemoteId(Database conn, String id, String table) async {
    final reader = await conn.query(
      table,
      columns: ['id'],
      where: 'remote_id=?',
      whereArgs: [id],
    );
    if (reader.isNotEmpty) {
      final data = reader[0];
      return data["id"] as int;
    }
    return 0;
  }
}
