import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:match_estudos_app/src/components/navigatton_bar/navigatton_bar_views.dart';
import 'package:match_estudos_app/src/features/login/view/login_ou_cadastro.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AuthViewmodel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthViewmodel>();

    if (session.carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body:
          session.user != null
              ? NavigattonBarViews(indexView: 0)
              : LoginOuCadastro(),
    );
  }
}
