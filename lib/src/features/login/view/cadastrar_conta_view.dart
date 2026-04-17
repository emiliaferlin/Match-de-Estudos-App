import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/components/campo_text/text_form_field_login.dart';
import 'package:match_estudos_app/src/components/notification/notification.dart';
import 'package:match_estudos_app/src/core/shared/constantes.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';
import 'package:match_estudos_app/src/features/login/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class CadastrarContaView extends StatefulWidget {
  final Function()? onTap;
  const CadastrarContaView({super.key, required this.onTap});

  @override
  State<CadastrarContaView> createState() {
    return CadastrarContaViewState();
  }
}

class CadastrarContaViewState extends State<CadastrarContaView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailText = TextEditingController();
  TextEditingController senhaText = TextEditingController();
  TextEditingController confirmaSenhaText = TextEditingController();

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
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Por favor, preenchar os seus dados para continuar. ',
                    style: TextStyleMatchEstudo.bodyLG(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  TextFormFieldLogin(
                    controller: emailText,
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
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: senhaText,
                    hintText: 'Senha',
                    campoSenha: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: confirmaSenhaText,
                    hintText: 'Confirmar senha',
                    campoSenha: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true) {
                        try {
                          await context.read<AuthViewmodel>().registrarUsuario(
                            emailText.text,
                            senhaText.text,
                          );

                          if (!mounted) return;

                          Navigator.pop(context);

                          NotificationMatchEstudo.sucess(
                            context,
                            message: "Usuário registrado com sucesso!",
                          );
                        } catch (e) {
                          if (!mounted) return;
                          NotificationMatchEstudo.warning(
                            context,
                            message: e.toString(),
                          );
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
                      "Registrar",
                      style: TextStyleMatchEstudo.titleSM(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta? ',
                        style: TextStyleMatchEstudo.bodyMD(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Faça login.',
                          style: TextStyleMatchEstudo.bodyMD(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
