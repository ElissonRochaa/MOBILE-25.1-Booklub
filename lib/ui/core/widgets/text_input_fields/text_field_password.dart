import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:booklub/ui/core/view_models/input_field_validation.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword({super.key});

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool _hidePassword = true;

  InputFieldValidation viewModel = InputFieldValidation();

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 45,
      child: Stack(
        children: [
          _buildPasswordField(theme),
          TopInnerShadow(),
        ],
      ),
    );
  }

  Widget _buildPasswordField(ThemeData theme) {
    return TextFormField(
      obscureText: _hidePassword,
      validator: (value) => viewModel.validatePassword(value!),
      decoration: InputDecoration(
        labelText: 'Senha',
        labelStyle: TextStyle(color: theme.colorScheme.onSurface),
        filled: true,
        fillColor: theme.colorScheme.surface,
        enabledBorder: _border(),
        focusedBorder: _border(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        suffixIcon: IconButton(
          icon: Icon(
            _hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: theme.colorScheme.secondary,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }
}
