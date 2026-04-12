import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/components/campo_text/text_form_field_login.dart';
import 'package:match_estudos_app/src/components/notification/notification.dart';
import 'package:match_estudos_app/src/shared/constantes.dart';
import 'package:match_estudos_app/src/shared/text_style/textstyle.dart';

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
  TextEditingController nomeText = TextEditingController();
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
                  SizedBox(
                    height: 100,
                    child: ClipOval(child: Image.asset('assets/logo.png')),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Por favor, preenchar os seus dados para continuar. ',
                    style: TextStyleMatchEstudo.bodyLG(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  TextFormFieldLogin(
                    controller: nomeText,
                    hintText: 'Nome completo',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: emailText,
                    hintText: 'Email',
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
                    onPressed: () {},
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

  void genericErrorMessage(String message) {
    NotificationMatchEstudo.warning(context, message: message);
  }
}
