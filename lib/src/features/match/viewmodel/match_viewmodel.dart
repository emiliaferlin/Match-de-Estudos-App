import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/match/model/match_model.dart';
import 'package:match_estudos_app/src/features/match/repository/match_repository.dart';
import 'package:match_estudos_app/src/features/perfil/model/perfil_model.dart';
import 'package:match_estudos_app/src/features/sessao/model/sessao_model.dart';

class MatchViewmodel extends ChangeNotifier {
  final MatchRepository matchRepository = MatchRepository();

  List<MatchModel> matches = [];
  bool loadingList = false;
  bool loadingCalc = false;
  String? errorMessage;
  MatchModel? lastCalculated;

  Future<void> fetchMatches(int perfilId) async {
    loadingList = true;
    errorMessage = null;
    notifyListeners();
    try {
      matches = await matchRepository.listarMatches(perfilId);
    } catch (e) {
      errorMessage = 'Erro ao carregar matches: $e';
    } finally {
      loadingList = false;
      notifyListeners();
    }
  }

  Future<void> calcularMatch(int perfilId, int sessaoId) async {
    loadingCalc = true;
    errorMessage = null;
    lastCalculated = null;
    notifyListeners();
    try {
      final result = await matchRepository.calcularMatch(
        MatchModel(perfilId: perfilId, sessaoId: sessaoId),
      );
      lastCalculated = result;
      if (result.aprovado == true) {
        matches = [result, ...matches];
      }
    } catch (e) {
      errorMessage = 'Erro ao calcular match: $e';
    } finally {
      loadingCalc = false;
      notifyListeners();
    }
  }

  Future<List<PerfilModel>> getPerfis() async {
    return await matchRepository.listarPerfis();
  }

  Future<List<SessaoModel>> getSessoes() async {
    return await matchRepository.listarSessoes();
  }

  void clearData() {
    matches = [];
    lastCalculated = null;
    errorMessage = null;
    loadingList = false;
    loadingCalc = false;

    notifyListeners();
  }
}
