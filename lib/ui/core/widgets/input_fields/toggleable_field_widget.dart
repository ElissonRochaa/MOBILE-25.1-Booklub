import 'package:flutter/material.dart';

class ToggleableFieldWidget extends StatelessWidget {

  final String? label;

  final TextStyle? labelStyle;

  final bool value;

  final ValueChanged<bool>? onChanged;

  const ToggleableFieldWidget({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.labelStyle
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      spacing: 8,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: colorScheme.primary,
          inactiveThumbColor: colorScheme.secondary,
        ),
        if (label != null) Text(
          label!,
          style: labelStyle
        ),
      ],
    );
  }

}
