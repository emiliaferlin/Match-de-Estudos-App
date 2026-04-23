import 'package:dio/dio.dart';
import 'package:match_estudos_app/src/core/network/http_client.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';

class PerfilRepository {
  final Dio _dio = HttpClient.create();

  Future<List<PerfilModel>> listarPerfis() async {
    final response = await _dio.get('/perfis');
    final List data = response.data;
    return data.map((e) => PerfilModel.fromMap(e)).toList();
  }

  Future<void> criarPerfil(PerfilModel perfil) async {
    await _dio.post('/perfis', data: perfil.toMap());
  }

  Future<void> editarPerfil(int id, PerfilModel perfil) async {
    await _dio.put('/perfis/$id', data: perfil.toMap());
  }

  Future<void> excluirPerfil(int id) async {
    await _dio.delete('/perfis/$id');
  }
}
