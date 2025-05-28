import 'package:booklub/ui/core/view_models/input_field_validation.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_password.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/login/widgets/cadastrar_clickable_text.dart';
import 'package:booklub/ui/login/widgets/esqueceu_senha_clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _RecoverPasswordPage();
}

class _RecoverPasswordPage extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final InputFieldValidation fieldValidatorModel = InputFieldValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(child: _buildBackButton(context)),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: _buildLoginForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Theme.of(context).colorScheme.primary,
        onPressed: () => context.pop(),
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

  Widget _buildTextMessage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recuperação de Conta",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Digite o e-mail referente à sua conta e iremos te enviar um e-mail com instruções pra recuperar sua senha.",
          textAlign: TextAlign.left,
          style: TextStyle(color: theme.colorScheme.primary, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextMessage(context),
        const SizedBox(height: 30),
        _buildTextFields(),
        const SizedBox(height: 30),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildTextFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldWithFieldName("E-mail", fieldValidatorModel.validateEmail),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [PurpleRoundedButton("Enviar e-mail", () => _submitForm(context))],
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // Api call aqui qnd a gnt for itnegrar
      context.push("/check-email-recover");
    }
  }
}
