import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/perfil/repository/perfil_repositry.dart';

class PerfilViewModel extends ChangeNotifier {
  final PerfilRepository _repo = PerfilRepository();

  List<PerfilModel> perfis = [];
  bool loading = false;
  String? error;

  Future<void> fetchPerfis() async {
    loading = true;
    notifyListeners();

    try {
      perfis = await _repo.listarPerfis();
    } catch (e) {
      error = "Erro ao carregar perfis";
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addPerfil(PerfilModel perfil) async {
    await _repo.criarPerfil(perfil);
    await fetchPerfis();
  }
}
