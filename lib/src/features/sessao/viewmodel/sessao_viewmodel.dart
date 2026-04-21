import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';
import 'package:match_estudos_app/src/features/sessao/repository/sessao_repository.dart';

class SessaoViewModel extends ChangeNotifier {
  final SessaoRepository _repo = SessaoRepository();

  List<SessaoModel> sessoes = [];
  bool loading = false;
  String? error;

  Future<void> fetchSessoes() async {
    loading = true;
    notifyListeners();

    try {
      sessoes = await _repo.listarSessoes();
    } catch (e) {
      error = "Erro ao carregar sessões";
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addSessao(SessaoModel sessao) async {
    await _repo.criarSessao(sessao);
    await fetchSessoes();
  }
}
