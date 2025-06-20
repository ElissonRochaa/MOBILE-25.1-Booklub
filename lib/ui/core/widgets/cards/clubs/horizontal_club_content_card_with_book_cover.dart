import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/core/widgets/cards/books/horizontal_card_with_book_cover.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalClubContentCardWithBookCover extends StatelessWidget {

  final String title;

  final Club club;

  final BookItem bookItem;

  final bool showClubHeader;

  final DateTime createdAt;

  final List<Widget> children;

  const HorizontalClubContentCardWithBookCover({
    super.key,
    required this.title,
    required this.club,
    required this.bookItem,
    required this.createdAt,
    required this.children,
    this.showClubHeader = false
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalCardWithBookCover(
      title: title,
      bookItem: bookItem,
      header: Builder(builder: _buildHeader),
      children: children,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        if (showClubHeader) Row(
          spacing: 8,
          children: [
            CircleImageWidget(
              borderWidth: 0,
              backgroundColor: colorScheme.white,
              radius: 24,
            ),
            Text(club.name, style: textTheme.labelMedium!.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold
            ))
          ]
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(createdAt),
          style: textTheme.labelMedium!.copyWith(
            color: colorScheme.onPrimary,
          )
        ),
      ],
    );
  }

}
