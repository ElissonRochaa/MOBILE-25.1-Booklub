import 'package:booklub/ui/core/widgets/input_fields/named_text_field_widget.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NamedDateFieldWidget extends StatelessWidget {

  final String label;

  final InputWrapper inputWrapper;

  final DateTime? initialDate;

  final DateTime? firstDate;

  final DateTime? lastDate;

  const NamedDateFieldWidget({
    super.key,
    required this.label,
    required this.inputWrapper,
    this.initialDate,
    this.firstDate,
    this.lastDate
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: NamedTextFieldWidget(
          label: label,
          inputWrapper: inputWrapper
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    final currentDate = inputWrapper.text;
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
      inputWrapper.text = formattedDate;
    }
  }

}
