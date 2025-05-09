import 'package:booklub/ui/core/view_models/input_field_validation.dart';
import 'package:booklub/ui/core/widgets/buttons/purple_rounded_button.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_password.dart';
import 'package:booklub/ui/core/widgets/text_input_fields/text_field_with_field_name.dart';
import 'package:booklub/ui/register/widgets/logar_clickable_text.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final InputFieldValidation fieldValidatorModel = InputFieldValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_buildBackground(), _buildForm(context)]),
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

  Widget _buildForm(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            SizedBox(height: 25),
            _buildTextFields(),
            SizedBox(height: 30),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/booklub_logo_icon.png',
      height: MediaQuery.sizeOf(context).height * 0.20,
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        PurpleRoundedButton("Cadastrar", () => _submitForm()),
        SizedBox(height: 16),
        LogarClickableText(),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Api call aqui qnd a gnt for itnegrar
    }
  }

  Widget _buildTextFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildNameFields(),
          SizedBox(height: 16),
          _buildDateAndUserFields(),
          SizedBox(height: 16),
          TextFieldWithFieldName("E-mail", fieldValidatorModel.validateEmail),
          SizedBox(height: 16),
          TextFieldPassword(),
        ],
      ),
    );
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        TextFieldWithFieldName(
          "Nome",
          fieldValidatorModel.validateBasicTextField,
        ),
        SizedBox(height: 16),
        TextFieldWithFieldName(
          "Sobrenome",
          fieldValidatorModel.validateBasicTextField,
        ),
      ],
    );
  }

  Widget _buildDateAndUserFields() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFieldWithFieldName(
            "Usuário",
            fieldValidatorModel.validateBasicTextField,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: TextFieldWithFieldName(
            "Nascimento",
            fieldValidatorModel.validateBasicTextField,
          ),
        ),
      ],
    );
  }

}
