import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:flutter/material.dart';

class TextFieldWithFieldName extends StatelessWidget {
  final String text;

  TextFieldWithFieldName(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: theme.colorScheme.onSurface),
            filled: true, // important to allow color behind gradient
            fillColor: theme.colorScheme.background,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        TopInnerShadow(),
      ],
    );
  }
}
