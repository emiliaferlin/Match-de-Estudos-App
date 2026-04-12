import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/components/navigatton_bar/navigatton_bar_views.dart';
import 'package:match_estudos_app/src/view/login/login_ou_cadastro.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        //stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigattonBarViews(indexView: 0);
          } else {
            return LoginOuCadastro();
          }
        },
      ),
    );
  }
}
