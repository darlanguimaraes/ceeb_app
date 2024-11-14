import 'dart:developer';

import 'package:ceeb_app/app/core/exceptions/repository_exception.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';

import './synchronize_repository.dart';

class SynchronizeRepositoryImpl implements SynchronizeRepository {
  final DioRestClient _dio;

  SynchronizeRepositoryImpl({required DioRestClient dio}) : _dio = dio;

  @override
  Future<String> login(String url, String email, String password) async {
    try {
      final response = await _dio.post(
        '${url}login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        return data['token'];
      } else {
        return '';
      }
    } catch (e, s) {
      log('Erro ao realizar o login', error: e, stackTrace: s);
      throw RepositoryException('Erro ao realizar o login');
    }
  }
}
