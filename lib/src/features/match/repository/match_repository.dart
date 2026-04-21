import 'package:dio/dio.dart';
import 'package:match_estudos_app/src/core/network/api_exception.dart';
import 'package:match_estudos_app/src/core/network/http_client.dart';
import 'package:match_estudos_app/src/features/match/model/match_model.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';

class MatchRepository {
  final Dio _dio = HttpClient.create();

  /// POST /matches — calcula o score entre perfil e sessão
  Future<MatchModel> calcularMatch(MatchModel request) async {
    try {
      final response = await _dio.post('/matches', data: request.toMap());

      return MatchModel.fromMap(response.data);
    } on ApiException {
      rethrow;
    }
  }

  /// GET /perfis/:id/matches — lista matches aprovados do perfil
  Future<List<MatchModel>> listarMatches(int perfilId) async {
    try {
      final response = await _dio.get('/perfis/$perfilId/matches');

      final List data = response.data as List;

      return data.map((e) => MatchModel.fromMap(e)).toList();
    } on ApiException {
      rethrow;
    }
  }

  Future<List<PerfilModel>> listarPerfis() async {
    try {
      final response = await _dio.get('/perfis');

      final List data = response.data;

      return data.map((e) => PerfilModel.fromMap(e)).toList();
    } on ApiException {
      rethrow;
    }
  }

  Future<List<SessaoModel>> listarSessoes() async {
    try {
      final response = await _dio.get('/sessoes');

      final List data = response.data;

      return data.map((e) => SessaoModel.fromMap(e)).toList();
    } on ApiException {
      rethrow;
    }
  }
}
