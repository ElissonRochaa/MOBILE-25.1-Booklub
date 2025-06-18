import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/ui/core/widgets/cards/horizontal_club_content_card_with_book_cover.dart';
import 'package:flutter/material.dart';

class ClubActivityCardWidget extends StatelessWidget {

  final String title;

  final Club club;

  final Activity activity;

  final BookItem bookItem;

  final bool showClubHeader;

  final List<Widget> children;

  const ClubActivityCardWidget({
    super.key,
    required this.title,
    required this.club,
    required this.activity,
    required this.bookItem,
    required this.children,
    this.showClubHeader = false,
  });

  @override
  Widget build(BuildContext context) {

    return HorizontalClubContentCardWithBookCover(
        title: title,
        club: club,
        bookItem: bookItem,
        createdAt: activity.createdAt,
        showClubHeader: showClubHeader,
        children: children
    );
  }

}
