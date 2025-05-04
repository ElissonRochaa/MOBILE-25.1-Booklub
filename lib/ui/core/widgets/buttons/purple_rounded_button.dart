import 'package:flutter/material.dart';

class PurpleRoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PurpleRoundedButton(this.label,this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
  final ThemeData theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        backgroundColor: theme.colorScheme.primary,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 25, fontFamily: 'Navicula'),
      ),
      onPressed: onPressed,
    );
  }
}
