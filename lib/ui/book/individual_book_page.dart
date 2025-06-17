import 'package:flutter/material.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:booklub/ui/book/widgets/review_card_widget.dart';
import 'package:booklub/ui/book/widgets/star_rating_widget.dart';
import 'package:booklub/ui/book/widgets/stats_card_widget.dart';

class IndividualBookPage extends StatelessWidget {
  const IndividualBookPage({super.key, required this.bookId});

  final String bookId; // o isbn

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ScrollBaseLayout(
      sliver: MultiSliver(
        children: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCoverAndTitleSection(textTheme, colorScheme),
                  const SizedBox(height: 16),
                  _buildClubStatsSection(colorScheme),
                  const SizedBox(height: 16),
                  _buildRatingSection(),
                  const SizedBox(height: 24),
                  _buildReviewSection(context, textTheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverAndTitleSection(
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 229,
            width: 153,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/misery_capa.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Misery",
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontFamily: 'Navicula',
              fontSize: 42,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Stephen King",
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.secondary,
              fontFamily: 'Navicula',
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClubStatsSection(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatsCard(
          number: '45',
          label: 'clubes já leram',
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 20),
        StatsCard(
          number: '13',
          label: 'clubes estão lendo',
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    const double rating = 4.38;

    return const Center(child: StarRating(rating: rating));
  }

  Widget _buildReviewSection(BuildContext context, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Resenhas",
          style: textTheme.titleMedium?.copyWith(
            fontFamily: 'Navicula',
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 28,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          3,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: ReviewCard(
              profileImageUrl: 'assets/images/mrbeast_profile_picture.jpg',
              displayName: 'Michael Albuquerque',
              username: 'michael_reads',
              rating: 4.5,
              review: 'Ameiii muito o livro',
            ),
          ),
        ),
      ],
    );
  }
}
