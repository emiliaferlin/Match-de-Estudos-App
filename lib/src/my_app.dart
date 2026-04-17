import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/features/login/view/auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthScreen());
  }
}
