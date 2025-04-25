import 'package:flutter/material.dart';

class PurpleRoundedButton extends StatelessWidget {
  final String label;

  const PurpleRoundedButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
  final ThemeData theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50),
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: theme.textTheme.bodyLarge?.fontSize ?? 14.0),
      ),
      onPressed: () {},
    );
  }
}
