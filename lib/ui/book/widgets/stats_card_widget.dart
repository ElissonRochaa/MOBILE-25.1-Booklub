import 'package:flutter/material.dart';
import 'package:booklub/config/theme/theme_config.dart';

class StatsCard extends StatelessWidget {
  final String number;
  final String label;
  final ColorScheme colorScheme;

  const StatsCard({
    super.key,
    required this.number,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: textTheme.titleSmall?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
              fontFamily: 'Navicula',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
