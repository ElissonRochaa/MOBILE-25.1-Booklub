import 'package:booklub/domain/entities/clubs/activities/new_meeting.dart';
import 'package:booklub/ui/clubs/profile/widgets/activity_card.dart';
import 'package:booklub/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class NewMeetingActivityCard extends StatelessWidget {

  final NewMeeting newMeeting;

  const NewMeetingActivityCard({
    super.key,
    required this.newMeeting,
  });

  @override
  Widget build(BuildContext context) {
    return ActivityCard(
      activity: 'Novo encontro marcado',
      title: newMeeting.location,
      additionalContent: Column(
        children: [
          Text(newMeeting.bookId), // TODO book title
          Row(
            children: [
              // TODO users images
              Text(DateFormatter.formatToDayMonthYear(newMeeting.date))
            ],
          )
        ],
      )
    );
  }

}
