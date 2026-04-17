import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:match_estudos_app/src/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewmodel())],
      child: const MyApp(),
    ),
  );
}
