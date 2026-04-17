import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/view/auth.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SairView extends StatefulWidget {
  const SairView({super.key});

  @override
  State<SairView> createState() => _SairViewState();
}

class _SairViewState extends State<SairView> {
  @override
  void initState() {
    funcaoSair();
    super.initState();
  }

  funcaoSair() async {
    final authViewmodel = context.read<AuthViewmodel>();
    await authViewmodel.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
