import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText; // nao exibe diretamente o texto

  const EditableField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextTheme.of(
        context,
      ).titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(
          Icons.edit_note_outlined,
          color: colorScheme.primary,
          size: 24,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: colorScheme.white, //o branco mas do figma
      ),
    );
  }
}
