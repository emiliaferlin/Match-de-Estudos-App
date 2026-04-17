import 'package:flutter/material.dart';
import 'package:match_estudos_app/src/core/shared/text_style/textstyle.dart';

class TextFormFieldLogin extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? campoSenha;
  const TextFormFieldLogin({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.campoSenha,
  });

  @override
  State<TextFormFieldLogin> createState() => _TextFormFieldLoginState();
}

class _TextFormFieldLoginState extends State<TextFormFieldLogin> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    void toggle() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }

    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      controller: widget.controller,
      validator: widget.validator,
      autocorrect: false,
      decoration: InputDecoration(
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.white,
          ),
        ),
        hintText: widget.hintText,
        hoverColor: Colors.white,
        errorMaxLines: 1,
        hintMaxLines: 1,
        helperMaxLines: 1,
        suffixIcon:
            widget.campoSenha == true
                ? _obscureText
                    ? IconButton(
                      onPressed: () => toggle(),
                      icon: Icon(Icons.visibility, color: Colors.white),
                    )
                    : GestureDetector(
                      onTap: () => toggle(),
                      child: Icon(Icons.visibility_off, color: Colors.white),
                    )
                : null,
        contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
        errorStyle: TextStyleMatchEstudo.bodyMD(color: Colors.white),
        hintStyle: TextStyleMatchEstudo.bodyMD(color: Colors.white),
        labelStyle: TextStyleMatchEstudo.bodyMD(color: Colors.white),

        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.white,
          ),
        ),
      ),
      obscureText: widget.campoSenha == true && _obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
