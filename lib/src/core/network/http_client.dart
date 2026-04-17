import 'package:dio/dio.dart';
import 'package:match_estudos_app/src/core/storage/auth_storage.dart';
import 'api_exception.dart';

class HttpClient {
  static const _baseUrl = 'http://10.0.2.2:8080';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(_AuthInterceptor());
    dio.interceptors.add(_ErrorInterceptor());

    return dio;
  }
}

// Injeta o token em toda requisição
class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AuthStorage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

// Trata erros de forma centralizada
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const ApiException(message: 'Tempo de conexão esgotado.'),
          ),
        );

      case DioExceptionType.connectionError:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const ApiException(message: 'Sem conexão com o servidor.'),
          ),
        );

      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        final serverMessage = response?.data?['message'] as String?;

        ApiException exception;

        switch (statusCode) {
          case 400:
            exception = ApiException(
              statusCode: 400,
              message: serverMessage ?? 'Requisição inválida.',
            );
          case 401:
            AuthStorage.deleteToken();
            exception = ApiException(
              statusCode: 401,
              message:
                  serverMessage ?? 'Sessão expirada. Faça login novamente.',
            );
          case 403:
            exception = ApiException(
              statusCode: 403,
              message: serverMessage ?? 'Acesso negado.',
            );
          case 404:
            exception = ApiException(
              statusCode: 404,
              message: serverMessage ?? 'Recurso não encontrado.',
            );
          case 500:
            exception = ApiException(
              statusCode: 500,
              message: 'Erro interno do servidor.',
            );
          default:
            exception = ApiException(
              statusCode: statusCode,
              message: serverMessage ?? 'Erro inesperado.',
            );
        }

        return handler.reject(
          DioException(requestOptions: err.requestOptions, error: exception),
        );

      default:
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: ApiException(message: err.message ?? 'Erro desconhecido.'),
          ),
        );
    }
  }
}
