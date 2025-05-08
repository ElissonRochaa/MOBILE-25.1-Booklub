import 'package:flutter/material.dart';
import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/ui/book/widgets/star_rating_widget.dart';

class ReviewCard extends StatelessWidget {
  final String profileImageUrl;
  final String displayName;
  final String username;
  final double rating;
  final String review;

  const ReviewCard({
    super.key,
    required this.profileImageUrl,
    required this.displayName,
    required this.username,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
        children: [
          // User Info Row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(profileImageUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '@$username',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Rating
          StarRating(rating: rating, iconSize: 20, showNumber: false),
          const SizedBox(height: 8),
          // Review Text
          Text(review, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
