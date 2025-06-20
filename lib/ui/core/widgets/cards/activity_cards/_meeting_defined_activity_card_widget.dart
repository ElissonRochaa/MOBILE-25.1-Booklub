import 'package:booklub/domain/activities/club_activities/entities/meeting_defined_activity.dart';
import 'package:booklub/domain/entities/books/book_item.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/ui/core/view_models/book_view_model.dart';
import 'package:booklub/ui/core/view_models/club_view_model.dart';
import 'package:booklub/ui/core/view_models/meeting_view_model.dart';
import 'package:booklub/ui/core/view_models/reading_goal_view_model.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_club_activity_card_widget.dart';
import 'package:booklub/utils/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef _Dependencies = ({Club club, Meeting meeting, BookItem book});

class MeetingDefinedActivityCardWidget extends StatelessWidget {
  final MeetingDefinedActivity activity;

  final bool showClubHeader;

  const MeetingDefinedActivityCardWidget({
    super.key,
    required this.activity,
    this.showClubHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: _getDependencies(context),
      onRetrieved:
          (data) => Builder(builder: (context) => _buildCard(context, data)),
      onLoading: () => const Card(),
      onError: (_, _) => const Card(),
    );
  }

  Future<_Dependencies> _getDependencies(BuildContext context) async {
    final clubViewModel = context.read<ClubViewModel>();
    final bookViewModel = context.read<BookViewModel>();
    final meetingViewModel = context.read<MeetingViewModel>();
    final readingGoalViewModel = context.read<ReadingGoalViewModel>();

    final club = await clubViewModel.getClub(activity.clubId);
    final meeting = await meetingViewModel.getMeeting(activity.meetingId);
    final readingGoal = await readingGoalViewModel.findById(
      meeting!.readingGoalId,
    );
    final book = await bookViewModel.getBook(readingGoal!.bookId);

    return (club: club!, meeting: meeting, book: book!);
  }

  Widget _buildCard(BuildContext context, _Dependencies dependencies) {
    final club = dependencies.club;
    final book = dependencies.book;
    final meeting = dependencies.meeting;

    final address = Row(
      spacing: 8,
      children: [
        Icon(Icons.location_on_rounded),
        Expanded(child: Text(meeting.address, overflow: TextOverflow.clip)),
      ],
    );

    final readingGoalBook = Row(
      spacing: 8,
      children: [Icon(Icons.menu_book_rounded), Text(book.title)],
    );

    return ClubActivityCardWidget(
      title: 'Atividade: Encontro Definido',
      club: club,
      activity: activity,
      bookItem: book,
      showClubHeader: showClubHeader,
      children: [address, readingGoalBook],
    );
  }
}
