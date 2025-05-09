import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),

          Text(
            title,
            style: TextTheme.of(context).titleMedium!.copyWith(
              fontFamily: "Navicula",
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 4.0,
              indent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
