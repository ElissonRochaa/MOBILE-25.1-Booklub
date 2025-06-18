import 'package:booklub/domain/entities/clubs/activities/reading_goal.dart';
import 'package:booklub/utils/date_formatter.dart';
import 'package:flutter/material.dart';

import 'activity_card_widget.dart';

class ReadingGoalActivityCardWidget extends StatelessWidget {

  final ReadingGoal readingGoal;

  const ReadingGoalActivityCardWidget({
    super.key,
    required this.readingGoal
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Icon(Icons.calendar_month_rounded),
            Text(DateFormatter.formatToDayMonthYear(readingGoal.startDate)),
            Icon(Icons.arrow_forward_rounded, size: 16),
            Text(DateFormatter.formatToDayMonthYear(readingGoal.finishDate)),
          ]
        ),
      ],
    );

    return ActivityCardWidget(
      activity: 'Nova meta de leitura',
      title: readingGoal.bookId, // TODO book title
      additionalContent: Expanded(
        child: content,
      ),
    );
  }
}
