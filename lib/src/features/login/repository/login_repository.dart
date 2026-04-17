import 'package:dio/dio.dart';
import 'package:match_estudos_app/src/core/network/api_exception.dart';
import 'package:match_estudos_app/src/core/network/http_client.dart';
import 'package:match_estudos_app/src/core/storage/auth_storage.dart';
import 'package:match_estudos_app/src/features/login/model/login_request_model.dart';
import 'package:match_estudos_app/src/features/login/model/login_response_model.dart';

class AuthRepository {
  final Dio _dio = HttpClient.create();

  Future<void> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post('/login', data: request.toMap());

      final loginResponse = LoginResponseModel.fromMap(response.data);
      await AuthStorage.saveToken(loginResponse.token!);
    } on ApiException {
      rethrow;
    }
  }

  Future<void> logout() async {
    await AuthStorage.deleteToken();
  }
}
