import 'package:booklub/domain/activities/user_activities/entities/user_completed_reading_activity.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/ui/core/view_models/book_view_model.dart';
import 'package:booklub/ui/core/view_models/user_view_model.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_user_activity_card_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef _Dependencies = ({User user, BookItem book});

class UserCompletedReadingActivityWidget extends StatelessWidget {

  final UserCompletedReadingActivity activity;

  final bool showUserHeader;

  const UserCompletedReadingActivityWidget({
    super.key,
    required this.activity,
    this.showUserHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: _getDependencies(context),
      onRetrieved: (data) => Builder(
        builder: (context) => _buildCard(context, data),
      ),
      onLoading: () => const Card(),
      onError: (_, __) => const Card(),
    );
  }

  Future<_Dependencies> _getDependencies(BuildContext context) async {
    final userViewModel = context.read<UserViewModel>();
    final bookViewModel = context.read<BookViewModel>();

    final user = await userViewModel.getUser(activity.userId);
    final book = await bookViewModel.getBook(activity.bookId);

    return (
      user: user!,
      book: book!,
    );
  }

  Widget _buildCard(BuildContext context, _Dependencies dependencies) {
    final user = dependencies.user;
    final book = dependencies.book;

    final bookTitle = Row(
      spacing: 8,
      children: [
        Icon(Icons.menu_book_rounded),
        Expanded(
          child: Text(
            book.title,
            overflow: TextOverflow.clip,
          )
        ),
      ],
    );

    final userInfo = Row(
      spacing: 8,
      children: [
        Icon(Icons.person_rounded),
      Expanded(
        child: Text(
          user.username,
          overflow: TextOverflow.clip,
        )
        ),
      ],
    );

    return UserActivityCardWidget(
      title: 'Atividade: Leitura Concluída por Membro',
      user: user,
      activity: activity,
      bookItem: book,
      showUserHeader: showUserHeader,
      children: [
        bookTitle,
        userInfo,
      ],
    );
  }

}
