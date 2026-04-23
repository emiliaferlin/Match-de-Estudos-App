import 'package:dio/dio.dart';
import 'package:match_estudos_app/src/core/network/http_client.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';

class SessaoRepository {
  final Dio _dio = HttpClient.create();

  Future<List<SessaoModel>> listarSessoes() async {
    final response = await _dio.get('/sessoes');
    final List data = response.data;
    return data.map((e) => SessaoModel.fromMap(e)).toList();
  }

  Future<void> criarSessao(SessaoModel sessao) async {
    await _dio.post('/sessoes', data: sessao.toMap());
  }

  Future<void> editarSessao(int id, SessaoModel sessao) async {
    await _dio.put('/sessoes/$id', data: sessao.toMap());
  }

  Future<void> excluirSessao(int id) async {
    await _dio.delete('/sessoes/$id');
  }
}
