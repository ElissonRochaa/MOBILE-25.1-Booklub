import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';

class NamedTimeFieldWidget extends StatelessWidget {
  final String label;
  final InputWrapper inputWrapper;
  final TimeOfDay? initialTime;

  const NamedTimeFieldWidget({
    super.key,
    required this.label,
    required this.inputWrapper,
    this.initialTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickTime(context),
      child: AbsorbPointer(
        child: NamedTextFieldWidget(
          label: label,
          inputWrapper: inputWrapper,
        ),
      ),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final now = TimeOfDay.now();
    final currentText = inputWrapper.text;

    TimeOfDay? initial = initialTime;
    if (currentText.isNotEmpty) {
      final parts = currentText.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          initial = TimeOfDay(hour: hour, minute: minute);
        }
      }
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: initial ?? now,
    );

    if (picked != null) {
      final formattedTime =
          picked.hour.toString().padLeft(2, '0') + ':' + picked.minute.toString().padLeft(2, '0');
      inputWrapper.text = formattedTime;
    }
  }
}
