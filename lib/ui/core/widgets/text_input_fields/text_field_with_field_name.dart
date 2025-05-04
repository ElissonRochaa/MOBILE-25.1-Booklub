import 'package:booklub/ui/core/widgets/top_inner_shadow.dart/top_inner_shadow.dart';
import 'package:flutter/material.dart';

class TextFieldWithFieldName extends StatefulWidget {
  final String text;
  final String? Function(String?) validator;

  const TextFieldWithFieldName(this.text, this.validator, {super.key});

  @override
  State<StatefulWidget> createState() => _TextFieldWithFieldNameState();
}

class _TextFieldWithFieldNameState extends State<TextFieldWithFieldName> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 45,
      child: Stack(children: [_buildTextField(theme), TopInnerShadow()]),
    );
  }

  Widget _buildTextField(ThemeData theme) {
    return TextFormField(
      validator: (value) => widget.validator(value),
      decoration: InputDecoration(
        labelText: widget.text,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
