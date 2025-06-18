import 'package:booklub/domain/activities/club_activities/entities/reading_goal_defined_activity.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/ui/core/view_models/book_view_model.dart';
import 'package:booklub/ui/core/view_models/club_view_model.dart';
import 'package:booklub/ui/core/view_models/reading_goal_view_model.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_club_activity_card_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

typedef _Dependencies = ({Club club, ReadingGoal readingGoal, BookItem book});

class ReadingGoalDefinedActivityCardWidget extends StatelessWidget {

  final ReadingGoalDefinedActivity activity;

  final bool showClubHeader;

  const ReadingGoalDefinedActivityCardWidget({
    super.key,
    required this.activity,
    this.showClubHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: _getDependencies(context),
      onRetrieved: (data) => Builder(
        builder: (context) => _buildCard(context, data),
      ),
      onLoading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      onError: (_, __) => const Card(),
    );
  }

  Future<_Dependencies> _getDependencies(BuildContext context) async {
    final clubViewModel = context.read<ClubViewModel>();
    final bookViewModel = context.read<BookViewModel>();
    final readingGoalViewModel = context.read<ReadingGoalViewModel>();

    final club = await clubViewModel.getClub(activity.clubId);
    final readingGoal = await readingGoalViewModel.findById(activity.readingGoalId);
    final book = await bookViewModel.getBook(readingGoal!.bookId);

    return (
      club: club!,
      readingGoal: readingGoal,
      book: book!,
    );
  }

  Widget _buildCard(BuildContext context, _Dependencies dependencies) {
    final club = dependencies.club;
    final book = dependencies.book;
    final readingGoal = dependencies.readingGoal;

    final bookTitle = Row(
      spacing: 8,
      children: [
        Icon(Icons.menu_book_rounded),
        Expanded(
          child: Text(
            book.title!,
            overflow: TextOverflow.clip,
          )
        ),
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

    return ClubActivityCardWidget(
      title: 'Atividade: Meta de Leitura Definida',
      club: club,
      activity: activity,
      bookItem: book,
      showClubHeader: showClubHeader,
      children: [
        bookTitle,
        schedule,
      ],
    );
  }

}
