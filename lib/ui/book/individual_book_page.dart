// ignore_for_file: avoid_print

import 'package:booklub/ui/book/view_models/book_profile_view_model.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:booklub/ui/core/layouts/scroll_base_layout.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:booklub/ui/book/widgets/review_card_widget.dart';
import 'package:booklub/ui/book/widgets/star_rating_widget.dart';
import 'package:booklub/ui/book/widgets/stats_card_widget.dart';

class IndividualBookPage extends StatelessWidget {
  const IndividualBookPage({super.key, required this.bookId});

  final String bookId; // o volumeId do livro

  @override
  Widget build(BuildContext context) {
    print('chegou no individual book page');
    final viewModel = context.read<BookProfileViewModel>();

    print('chegou depois do read');

    return AsyncBuilder.fromAsyncChangeNotifier(
      asyncChangeNotifier: viewModel,
      onRetrieved: (book) {
        print('chegou ate aqui');
        return Builder(builder: _buildPage);
      },
      onLoading: () => Builder(builder: _buildLoadingPage),
      onError: (_, __) => Builder(builder: _buildErrorPage),
    );
  }

  Widget _buildLoadingPage(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }

  Widget _buildErrorPage(BuildContext context) {
  final viewModel = context.read<BookProfileViewModel>();
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;

  return ScrollBaseLayout(
    sliver: SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Livro com ID "${viewModel.book?.id ?? bookId}" não encontrado',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}


  Widget _buildPage(BuildContext context) {
    final book = context.watch<BookProfileViewModel>();
    print('chegou no build page com book de id: ${book.book?.id}');
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
                  _buildCoverAndTitleSection(textTheme, colorScheme, book),
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
    book,
  ) {
    final bookData = book.book;
    print('chegou no buildCoverAndTitleSection com bookData: $bookData');
    final year =
        bookData?.datePublished != null && bookData?.datePublished!.isNotEmpty
            ? bookData!.datePublished!.split('-').first
            : null;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 229,
            width: 153,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    bookData.thumbnail != null
                        ? NetworkImage(bookData.thumbnail!)
                        : const AssetImage('assets/images/misery_capa.jpg')
                            as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            bookData.title,
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.primary,
              fontFamily: 'Navicula',
              fontSize: 42,
            ),
            textAlign: TextAlign.center,
          ),
          if (bookData.authors != null)
            Text(
              bookData.authors!,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.secondary,
                fontFamily: 'Navicula',
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          if (year != null)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    year,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildClubStatsSection(ColorScheme colorScheme) {
    print('chegou no buildClubStatsSection com colorScheme');
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
    print('chegou no buildRatingSection');
    const double rating = 4.38;
    return const Center(child: StarRating(rating: rating));
  }

  Widget _buildReviewSection(BuildContext context, TextTheme textTheme) {
    print('chegou no buildReviewSection com textTheme');
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
