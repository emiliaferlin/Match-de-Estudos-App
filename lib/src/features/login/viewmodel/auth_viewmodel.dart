import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/storage/auth_storage.dart';
import 'package:match_estudos_app/src/features/login/model/login_request_model.dart';
import 'package:match_estudos_app/src/features/login/model/usuario_model.dart';
import 'package:match_estudos_app/src/features/login/repository/login_repository.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();

  bool carregando = false;
  UsuarioModel? user;

  Future<void> init() async {
    final token = await AuthStorage.getToken();

    if (token != null) {
      user = UsuarioModel();
    }

    carregando = false;
    notifyListeners();
  }

  Future login(String email, String senha) async {
    try {
      carregando = true;
      notifyListeners();

      await authRepository.login(LoginRequestModel(email: email, senha: senha));

      return;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    user = null;
    notifyListeners();
  }
}
