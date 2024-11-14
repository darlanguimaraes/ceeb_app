import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/repositories/reader/reader_repository.dart';

import './reader_service.dart';

class ReaderServiceImpl implements ReaderService {
  final ReaderRepository _readerRepository;

  ReaderServiceImpl({required ReaderRepository readerRepository})
      : _readerRepository = readerRepository;

  @override
  Future<List<ReaderModel>> list(String? filter) async {
    return await _readerRepository.list(filter);
  }

  @override
  Future<void> save(ReaderModel reader) async {
    await _readerRepository.save(reader);
  }

  @override
  Future<void> update(ReaderModel reader) async {
    await _readerRepository.update(reader);
  }

  @override
  Future<ReaderModel> get(int id) async {
    return await _readerRepository.get(id);
  }

  @override
  Future<void> synchronize(String url, String token, DateTime date) async {
    await _readerRepository.sendData(url, token);
    await _readerRepository.receiveData(url, token, date);
  }
}
