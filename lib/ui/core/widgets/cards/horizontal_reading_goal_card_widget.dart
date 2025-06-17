import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_club_content_card_with_book_cover.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalReadingGoalCardWidget extends StatelessWidget {

  final ReadingGoal readingGoal;

  final Club club;

  final BookItem bookItem;

  final bool showClubHeader;

  const HorizontalReadingGoalCardWidget({
    super.key,
    required this.readingGoal,
    required this.club,
    required this.bookItem,
    this.showClubHeader = false
  });

  @override
  Widget build(BuildContext context) {
    final bookTitle = Row(
      spacing: 8,
      children: [
        Icon(Icons.menu_book_rounded),
        Text(readingGoal.bookId),
      ],
    );

    final schedule = Row(
      spacing: 8,
      children: [
        Icon(Icons.calendar_month_rounded),
        Text(DateFormat('dd/MM/yyyy').format(readingGoal.startDate)),
        Icon(Icons.arrow_forward_rounded, size: 16),
        Text(DateFormat('dd/MM/yyyy').format(readingGoal.endDate))
      ],
    );

    return HorizontalClubContentCardWithBookCover(
      title: 'Meta de Leitura',
      club: club,
      bookItem: bookItem,
      createdAt: readingGoal.createdAt,
      showClubHeader: showClubHeader,
      children: [
        bookTitle,
        schedule
      ]
    );
  }



}
