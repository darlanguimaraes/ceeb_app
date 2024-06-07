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
}
