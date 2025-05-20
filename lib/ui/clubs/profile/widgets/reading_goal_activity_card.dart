import 'package:booklub/domain/entities/clubs/activities/reading_goal.dart';
import 'package:booklub/ui/clubs/profile/widgets/activity_card.dart';
import 'package:booklub/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class ReadingGoalActivityCard extends StatelessWidget {

  final ReadingGoal readingGoal;

  const ReadingGoalActivityCard({
    super.key,
    required this.readingGoal
  });

  @override
  Widget build(BuildContext context) {
    return ActivityCard(
      activity: 'Nova meta de leitura',
      title: readingGoal.bookId, // TODO book title
      additionalContent: Row(
        spacing: 4,
        children: [
          Text(DateFormatter.formatToDayMonthYear(readingGoal.startDate)),
          Icon(Icons.arrow_forward_rounded, size: 16),
          Text(DateFormatter.formatToDayMonthYear(readingGoal.finishDate)),
        ]
      ),
    );
  }
}
