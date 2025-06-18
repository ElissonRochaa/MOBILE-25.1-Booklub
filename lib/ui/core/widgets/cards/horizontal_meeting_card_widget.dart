import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_club_content_card_with_book_cover.dart';
import 'package:flutter/material.dart';

class HorizontalMeetingCardWidget extends StatelessWidget {

  final Club club;

  final Meeting meeting;

  final BookItem book;

  final bool showClubHeader;

  const HorizontalMeetingCardWidget({
    super.key,
    required this.club,
    required this.meeting,
    required this.book,
    required this.showClubHeader,
  });

  @override
  Widget build(BuildContext context) {
    final address = Row(
      spacing: 8,
      children: [
        Icon(Icons.location_on_rounded),
        Expanded(
          child: Text(
            meeting.address,
            overflow: TextOverflow.clip
          )
        ),
      ],
    );

    final readingGoalBook = Row(
      spacing: 8,
      children: [
        Icon(Icons.menu_book_rounded),
        Text(book.title!),
      ],
    );

    return HorizontalClubContentCardWithBookCover(
      title: 'Encontro',
      club: club,
      bookItem: book,
      createdAt: meeting.createdAt,
      showClubHeader: showClubHeader,
      children: [
        address,
        readingGoalBook
      ]
    );
  }

}
