import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/widgets/cards/users/horizontal_user_content_card_with_book_cover.dart';
import 'package:flutter/material.dart';

class UserActivityCardWidget extends StatelessWidget {

  final String title;

  final User user;

  final Activity activity;

  final BookItem bookItem;

  final bool showUserHeader;

  final List<Widget> children;

  const UserActivityCardWidget({
    super.key,
    required this.title,
    required this.user,
    required this.activity,
    required this.bookItem,
    required this.children,
    this.showUserHeader = false,
  });

  @override
  Widget build(BuildContext context) {

    return HorizontalUserContentCardWithBookCover(
        title: title,
        user: user,
        bookItem: bookItem,
        createdAt: activity.createdAt,
        showUserHeader: showUserHeader,
        children: children
    );
  }

}