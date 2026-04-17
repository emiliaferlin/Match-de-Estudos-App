import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/model/usuario_model.dart';
import 'package:match_estudos_app/src/core/storage/auth_storage.dart';

class AuthViewmodel extends ChangeNotifier {
  UsuarioModel? user;
  bool carregando = true;

  Future<void> init() async {
    final token = await AuthStorage.getToken();

    if (token != null) {
      user = UsuarioModel();
    }

    carregando = false;
    notifyListeners();
  }

  void setUser(UsuarioModel user) {
    user = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthStorage.deleteToken();
    user = null;
    notifyListeners();
  }
}
