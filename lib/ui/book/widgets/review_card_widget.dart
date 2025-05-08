import 'package:flutter/material.dart';
import 'package:booklub/config/theme/theme_config.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("User123", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            "Really enjoyed this book, especially the character development!",
          ),
        ],
      ),
    );
  }
}
