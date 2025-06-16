import 'package:booklub/config/theme/theme_config.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:flutter/material.dart';

class HorizontalCardWithBookCover extends StatelessWidget {

  final String title;

  final BookItem bookItem;

  final Widget? header;

  final List<Widget>? children;

  const HorizontalCardWithBookCover({
    super.key,
    required this.title,
    required this.bookItem,
    this.header,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final cardTitle = Text(
        'Meta de Leitura',
        style: textTheme.labelLarge!.copyWith(
            fontFamily: 'Navicula',
            color: colorScheme.primary
        )
    );

    final content = Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTitle,
                  ...?children
                ],
              ),
              Builder(builder: _buildBookCover)
            ],
          ),
        ),
      ),
    );

    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
    );

    return Card(
      shape: shape,
      child: Column(
        children: [
          if (header != null) Builder(builder: _buildHeader),
          content
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: header,
    );
  }

  Widget _buildBookCover(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final decorationImage = bookItem.thumbnail != null
      ? DecorationImage(
          image: NetworkImage(bookItem.thumbnail!),
          fit: BoxFit.cover,
        )
      : null;

    return AspectRatio(
      aspectRatio: 2/3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: colorScheme.darkWhite,
          image: decorationImage
        ),
      ),
    );
  }

}
