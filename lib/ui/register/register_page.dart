import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_password.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:booklub/ui/register/widgets/logar_clickable_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
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
                    'assets/images/booklub_logo_icon.png',
                    height: MediaQuery.sizeOf(context).height * 0.20,
                  ),
                  SizedBox(height: 25),
                  Column(
                    children: [
                      TextFieldWithFieldName("Nome"),
                      SizedBox(height: 16),
                      TextFieldWithFieldName("Sobrenome"),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFieldWithFieldName("Usuário"),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextFieldWithFieldName("Nascimento"),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFieldWithFieldName("E-mail"),
                      SizedBox(height: 16),
                      TextFieldPassword(),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: [
                      PurpleRoundedButton(
                        "Cadastrar",
                        () => (),
                      ), //Tenho que adicionar logica de validação aqui e posteriormente api call
                      SizedBox(height: 16),
                      LogarClickableText(),
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
