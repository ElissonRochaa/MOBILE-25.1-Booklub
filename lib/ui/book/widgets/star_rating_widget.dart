import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double iconSize;

  const StarRating({super.key, required this.rating, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            i - 0.25 <= rating
                ? Icons.star_rounded
                : i - 0.75 <= rating
                ? Icons.star_half_rounded
                : Icons.star_border_rounded,
            color: theme.colorScheme.primary,
            size: iconSize,
          ),
        const SizedBox(width: 8),
        Padding(
          padding: EdgeInsets.only(bottom: iconSize * 0.05),
          child: Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: iconSize * 0.45,
            ),
          ),
        ),
      ],
    );
  }
}
