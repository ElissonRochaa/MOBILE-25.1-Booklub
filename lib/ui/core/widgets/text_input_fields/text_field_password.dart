import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        TextFormField(
          obscureText: hidePassword,
          decoration: InputDecoration(
            labelText: 'Senha',
            labelStyle: TextStyle(color: theme.colorScheme.onSurface),
            filled: true,
            fillColor: theme.colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                hidePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: theme.colorScheme.secondary,
              ),
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
            ),
          ),
        ),
        TopInnerShadow(),
      ],
    );
  }
}
