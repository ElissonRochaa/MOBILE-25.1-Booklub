import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const EditableDateField({
    super.key,
    required this.label,
    required this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          style: TextTheme.of(context)
              .titleSmall!
              .copyWith(color: colorScheme.primary),
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: Icon(
              Icons.edit_note_outlined, 
              color: colorScheme.primary,
              size: 24,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: colorScheme.white, 
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    final currentDate = controller.text;
    final initial = currentDate.isNotEmpty
      ? dateFormatter.parse(currentDate)
      : initialDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      initialDate: initial,
    );

    if (picked != null) {
      final formattedDate = dateFormatter.format(picked);
      controller.text = formattedDate;
    }
  }
}
