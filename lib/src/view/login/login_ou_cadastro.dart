import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/view/login/cadastrar_conta_view.dart';
import 'package:match_estudos_app/src/view/login/login_view.dart';

class LoginOuCadastro extends StatefulWidget {
  const LoginOuCadastro({super.key});

  @override
  State<LoginOuCadastro> createState() => _LoginOuCadastroState();
}

class _LoginOuCadastroState extends State<LoginOuCadastro> {
  bool showLoginScreen = true;

  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginView(onTap: togglePages);
    } else {
      return CadastrarContaView(onTap: togglePages);
    }
  }
}
