import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/domain/entities/clubs/activities/new_meeting.dart';
import 'package:booklub/domain/entities/clubs/activities/reading_goal.dart';
import 'package:booklub/ui/clubs/profile/widgets/completed_reading_activity_card.dart';
import 'package:booklub/ui/clubs/profile/widgets/new_meeting_activity_card.dart';
import 'package:booklub/ui/clubs/profile/widgets/reading_goal_activity_card.dart';
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
      ReadingGoal() => ReadingGoalActivityCard(
        readingGoal: clubActivity as ReadingGoal
      ),
      NewMeeting() => NewMeetingActivityCard(
        newMeeting: clubActivity as NewMeeting
      ),
      CompletedReading() => CompletedReadingActivityCard(
        completedReading: clubActivity as CompletedReading
      ),
      _ => throw UnimplementedError('Activity type not implemented'),
    };
  }

}
