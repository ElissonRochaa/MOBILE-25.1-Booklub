import 'package:booklub/domain/entities/clubs/activities/new_meeting_defined_activity.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/activity_card_widget.dart';
import 'package:booklub/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class NewMeetingActivityCardWidget extends StatelessWidget {

  final NewMeetingDefinedActivity newMeeting;

  const NewMeetingActivityCardWidget({
    super.key,
    required this.newMeeting,
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
            Icon(Icons.menu_book_rounded),
            Text(newMeeting.bookId),
          ],
        ), // TODO book title
        Row(
          spacing: 4,
          children: [
            // TODO users images
            Icon(Icons.calendar_month_rounded),
            Text(DateFormatter.formatToDayMonthYear(newMeeting.date))
          ],
        ),
      ],
    );

    return ActivityCardWidget(
      activity: 'Novo encontro marcado',
      title: newMeeting.location,
      additionalContent: Expanded(
        child: content
      )
    );
  }

}
