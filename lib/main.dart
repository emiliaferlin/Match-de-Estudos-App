import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:match_estudos_app/src/features/match/viewmodel/match_viewmodel.dart';
import 'package:match_estudos_app/src/features/perfil/viewmodel/perfil_viewmodel.dart';
import 'package:match_estudos_app/src/features/sessao/viewmodel/sessao_viewmodel.dart';
import 'package:match_estudos_app/src/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewmodel()),
        ChangeNotifierProvider(create: (_) => MatchViewmodel()),
        ChangeNotifierProvider(create: (_) => PerfilViewModel()),
        ChangeNotifierProvider(create: (_) => SessaoViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
