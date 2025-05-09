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
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextTheme.of(context).titleSmall!.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: "Navicula",
      ),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.edit_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Color(0xFFCFCFCF), //o branco mas do figma
      ),
    );
  }
}
