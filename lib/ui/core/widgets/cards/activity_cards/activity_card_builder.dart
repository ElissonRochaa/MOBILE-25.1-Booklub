import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/domain/entities/clubs/activities/new_meeting_defined_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/new_reading_goal_defined_activity.dart';
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
      NewReadingGoalDefinedActivity() => ReadingGoalActivityCardWidget(
        readingGoal: clubActivity as NewReadingGoalDefinedActivity
      ),
      NewMeetingDefinedActivity() => NewMeetingActivityCardWidget(
        newMeeting: clubActivity as NewMeetingDefinedActivity
      ),
      CompletedReading() => CompletedReadingActivityCardWidget(
        completedReading: clubActivity as CompletedReading
      ),
      _ => throw UnimplementedError('Activity type not implemented'),
    };
  }

}
