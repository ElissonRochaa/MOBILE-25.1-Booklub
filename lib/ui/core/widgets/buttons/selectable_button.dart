import 'package:booklub/config/theme/theme_config.dart';
import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {

  final String label;

  final bool selected;

  final VoidCallback? onPressed;

  const SelectableButton({
    super.key,
    required this.label,
    required this.selected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: selected ? colorScheme.primary : colorScheme.darkWhite,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: textTheme.labelMedium!.copyWith(
                color: selected ? colorScheme.white : colorScheme.primary
            ),
          ),
        ),
      ),
    );
  }

}
