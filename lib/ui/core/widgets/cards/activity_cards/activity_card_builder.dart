import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/domain/entities/clubs/activities/new_meeting.dart';
import 'package:booklub/domain/entities/clubs/activities/reading_goal.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/completed_reading_activity_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/new_meeting_activity_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/reading_goal_activity_card_widget.dart';
import 'package:flutter/material.dart';

class ActivityCardBuilder extends StatelessWidget {

  final ClubActivity clubActivity;

  const ActivityCardBuilder({
    super.key,
    required this.clubActivity
  });

  @override
  Widget build(BuildContext context) {
    return switch (clubActivity) {
      ReadingGoal() => ReadingGoalActivityCardWidget(
        readingGoal: clubActivity as ReadingGoal
      ),
      NewMeeting() => NewMeetingActivityCardWidget(
        newMeeting: clubActivity as NewMeeting
      ),
      CompletedReading() => CompletedReadingActivityCardWidget(
        completedReading: clubActivity as CompletedReading
      ),
      _ => throw UnimplementedError('Activity type not implemented'),
    };
  }

}
