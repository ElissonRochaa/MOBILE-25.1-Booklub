import 'package:booklub/config/routing/routes.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalBookCardWidget extends StatelessWidget {
  final BookItem book;

  const HorizontalBookCardWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(100),
      topRight: Radius.circular(36),
      bottomLeft: Radius.circular(100),
      bottomRight: Radius.circular(36),
    );

    final bookCover = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        book.thumbnail ?? '',
        height: 100,
        width: 70,
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) => Container(
              height: 100,
              width: 70,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
      ),
    );

    final bookInfo = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              book.title ?? 'Título desconhecido',
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    book.authors ?? 'Autor desconhecido',
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (book.datePublished != null && book.datePublished!.length >= 4)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  book.datePublished!.substring(0, 4), // mostra só o ano
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () {
        final id = book.id ?? 'sem-volumeId';
        context.push(Routes.individualBook(bookId: id));
      },
      borderRadius: borderRadius,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.all(8), child: bookCover),
            bookInfo,
          ],
        ),
      ),
    );
  }
}
