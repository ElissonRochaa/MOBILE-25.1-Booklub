import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_password.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/light-background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Booklub_logo.png',
                    height: MediaQuery.sizeOf(context).height * 0.28,
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      TextFieldWithFieldName("E-mail"),
                      SizedBox(height: 16),
                      TextFieldPassword(),
                      SizedBox(height: 16),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      PurpleRoundedButton("Entrar", () => ()), //Tenho que adicionar logica de validação aqui e posteriormente api call
                      SizedBox(height: 16),
                      CadastrarClickableText(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
