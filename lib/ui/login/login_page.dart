import 'package:booklub/ui/core/view_models/input_field_validation.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_password.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final InputFieldValidation fieldValidatorModel = InputFieldValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: _buildLoginForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.5,
        child: Image.asset(
          'assets/images/light-background.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(context),
        const SizedBox(height: 30),
        _buildTextFields(),
        const SizedBox(height: 30),
        _buildButtons(),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      'assets/images/Booklub_logo.png',
      height: MediaQuery.sizeOf(context).height * 0.28,
    );
  }

  Widget _buildTextFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldWithFieldName("E-mail", fieldValidatorModel.validateEmail),
          SizedBox(height: 16),
          TextFieldPassword(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        PurpleRoundedButton("Entrar", () => _submitForm()),
        SizedBox(height: 16),
        CadastrarClickableText(),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Api call aqui qnd a gnt for itnegrar
    }
  }
}
