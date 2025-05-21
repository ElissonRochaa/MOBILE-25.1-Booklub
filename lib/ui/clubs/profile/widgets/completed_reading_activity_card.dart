import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/ui/clubs/profile/widgets/activity_card.dart';
import 'package:booklub/ui/core/widgets/circle_image_widget.dart';
import 'package:booklub/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class CompletedReadingActivityCard extends StatelessWidget {

  final CompletedReading completedReading;

  const CompletedReadingActivityCard({
    super.key,
    required this.completedReading,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final userPicture = AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(
        builder: (context, constraints) => CircleImageWidget(
          borderColor: colorScheme.primary,
          borderWidth: 2,
          radius: 25,
        ),
      ),
    );


    final activityDetails = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('<username>', textAlign: TextAlign.center), // TODO user name
        Row(
          children: [
            Text(DateFormatter.formatToDayMonthYear(completedReading.startDate)),
            Icon(Icons.arrow_forward_rounded, size: 16),
            Text(DateFormatter.formatToDayMonthYear(completedReading.finishDate))
          ],
        )
      ],
    );

    final content = Row(
      children: [
        userPicture,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: activityDetails,
        )
      ]
    );

    return ActivityCard(
      activity: 'Leitura completa',
      title: completedReading.bookId,
      additionalContent: Expanded(
        child: content
      )
    );
  }
}
