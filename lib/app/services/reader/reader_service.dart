import 'package:ceeb_app/app/models/reader/reader_model.dart';

abstract interface class ReaderService {
  Future<void> save(ReaderModel reader);
  Future<void> update(ReaderModel reader);
  Future<List<ReaderModel>> list(String? filter);
  Future<ReaderModel> get(int id);
  Future<void> synchronize(String url, String token, DateTime date);
}
