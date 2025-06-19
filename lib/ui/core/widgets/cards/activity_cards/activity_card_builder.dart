import 'package:booklub/domain/activities/club_activities/entities/meeting_defined_activity.dart';
import 'package:booklub/domain/activities/club_activities/entities/member_completed_reading_activity.dart';
import 'package:booklub/domain/activities/club_activities/entities/reading_goal_defined_activity.dart';
import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/domain/activities/user_activities/entities/user_completed_reading_activity.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_meeting_defined_activity_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_member_completed_reading_activity_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_reading_goal_defined_activity_card_widget.dart';
import 'package:booklub/ui/core/widgets/cards/activity_cards/_user_completed_reading_activity_card_widget.dart';
import 'package:flutter/material.dart';

class ActivityCardBuilder extends StatelessWidget {

  final Activity activity;

  final bool showAuthorHeader;

  const ActivityCardBuilder({
    super.key,
    required this.activity,
    required this.showAuthorHeader
  });

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) => switch (activity) {
      MeetingDefinedActivity activity => _buildMeetingDefinedActivityCard(context, activity),
      MemberCompletedReadingActivity activity => _buildMemberCompletedReadingActivityCard(context, activity),
      ReadingGoalDefinedActivity activity => _buildReadingGoalDefinedActivityCard(context, activity),
      UserCompletedReadingActivity activity => _buildUserCompletedReadingActivityCard(context, activity),
      _ => throw UnimplementedError('Card for activity type ${activity.runtimeType} not implemented')
    },
  );

  Widget _buildMeetingDefinedActivityCard(
    BuildContext context,
    MeetingDefinedActivity activity
  ) {
    return MeetingDefinedActivityCardWidget(
      activity: activity,
      showClubHeader: showAuthorHeader
    );
  }

  Widget _buildMemberCompletedReadingActivityCard(
    BuildContext context,
    MemberCompletedReadingActivity activity
  ) {
    return MemberCompletedReadingActivityCardWidget(
      activity: activity,
      showClubHeader: showAuthorHeader
    );
  }

  Widget _buildReadingGoalDefinedActivityCard(BuildContext context, ReadingGoalDefinedActivity activity) {
    return ReadingGoalDefinedActivityCardWidget(
      activity: activity,
      showClubHeader: showAuthorHeader
    );
  }

  Widget _buildUserCompletedReadingActivityCard(BuildContext context, UserCompletedReadingActivity activity) {
    return UserCompletedReadingActivityWidget(
      activity: activity,
      showUserHeader: showAuthorHeader
    );
  }

}
