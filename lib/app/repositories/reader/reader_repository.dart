import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/models/sync/sync_model.dart';

abstract interface class ReaderRepository {
  Future<void> save(ReaderModel reader);
  Future<void> update(ReaderModel reader);
  Future<List<ReaderModel>> list(String? filter);
  Future<void> borrowBook(int id, bool borrow);
  Future<ReaderModel> get(int id);
  Future<void> sendData(String url, String token);
  Future<SyncModel> receiveData(String url, String token, DateTime date);
}
