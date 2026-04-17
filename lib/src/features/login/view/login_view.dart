import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/components/campo_text/text_form_field_login.dart';
import 'package:match_estudos_app/src/components/navigatton_bar/navigatton_bar_views.dart';
import 'package:match_estudos_app/src/components/notification/notification.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  final Function()? onTap;
  const LoginView({super.key, this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      backgroundColor: primaryColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 50.0),
                    child: TextFormFieldLogin(
                      controller: emailController,
                      hintText: 'E-mail',
                      validator: (value) {
                        bool emailValid = false;
                        if (value != null) {
                          emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-_]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                        }
                        if (value == null ||
                            value.isEmpty ||
                            emailValid == false) {
                          return "Insira um email valido";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: TextFormFieldLogin(
                      controller: senhaController,
                      hintText: 'Senha',
                      campoSenha: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          try {
                            final authViewModel = context.read<AuthViewmodel>();

                            await authViewModel.login(
                              emailController.text,
                              senhaController.text,
                            );

                            // após o login, verifica se o user foi setado
                            if (!mounted) return;

                            if (authViewModel.user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => NavigattonBarViews(indexView: 0),
                                ),
                              );
                            } else {
                              notificacaoGenerica('Erro ao fazer login');
                            }
                          } catch (e) {
                            if (!mounted) return;

                            notificacaoGenerica(e.toString());
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 46.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyleMatchEstudo.titleSM(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Quero me cadastrar',
                      style: TextStyleMatchEstudo.bodyMD(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void notificacaoGenerica(String message) {
    NotificationMatchEstudo.warning(context, message: message);
  }
}
