import 'dart:math';

import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/domain/entities/clubs/activities/new_meeting_defined_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/new_reading_goal_defined_activity.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/meetings/meetings_repository.dart';
import 'package:booklub/infra/reading_goals/reading_goals_repository.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';

class ClubProfileViewModel extends AsyncChangeNotifier {

  // ### Dependencies
  final ClubRepository _clubRepository;

  final ReadingGoalsRepository _readingGoalsRepository;

  final MeetingsRepository _meetingsRepository;

  final AuthViewModel _authViewModel;

  final String clubId;

  // ### Constructors
  ClubProfileViewModel({
    required ClubRepository clubRepository,
    required ReadingGoalsRepository readingGoalsRepository,
    required MeetingsRepository meetingsRepository,
    required AuthViewModel authViewModel,
    required this.clubId,
  }):
    _clubRepository = clubRepository,
    _readingGoalsRepository = readingGoalsRepository,
    _meetingsRepository = meetingsRepository,
    _authViewModel = authViewModel
  {
    _setClub(clubId);
  }

  // ### State
  final List<ClubActivity> _clubActivitiesDummies = [
    NewReadingGoalDefinedActivity(
        clubId: 'club123',
        bookId: 'book456',
        startDate: DateTime(2023, 1, 15),
        endDate: DateTime(2023, 2, 28)
    ),
    NewMeetingDefinedActivity(
        clubId: 'club789',
        bookId: 'book012',
        location: 'Central Park Cafe',
        participantsIds: ['user1', 'user2', 'user3'],
        date: DateTime(2023, 3, 10, 18, 30)
    ),
    CompletedReading(
        clubId: 'club345',
        bookId: 'book678',
        userId: 'userABC',
        startDate: DateTime(2023, 2, 1),
        finishDate: DateTime(2023, 2, 20)
    ),
    NewReadingGoalDefinedActivity(
      clubId: 'clubXYZ',
      bookId: 'bookDEF',
      startDate: DateTime(2023, 4, 1),
      endDate: DateTime(2023, 5, 15),
    ),
    NewMeetingDefinedActivity(
        clubId: 'clubLMN',
        bookId: 'bookOPQ',
        location: 'Library Community Room',
        participantsIds: ['userX', 'userY'],
        date: DateTime(2023, 6, 5, 19, 0)
    ),
    CompletedReading(
        clubId: 'clubRST',
        bookId: 'bookUVW',
        userId: 'user123XYZ',
        startDate: DateTime(2023, 5, 10),
        finishDate: DateTime(2023, 5, 30)
    ),
  ];

  Club? _club;

  @override
  Club? get payload => _club;

  Club? get club => payload;

  Future<void> _setClub(String clubId) async {
    clubId = clubId;
    isLoading = true;
    notifyListeners();

    try {
      _club = await _clubRepository.findClubById(clubId);
    } catch (e, trace) {
      error = (object: e, stackTrace: trace);
      _club = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void checkClubLoaded() {
    if (club == null) throw StateError('Club with id $clubId was not loaded');
  }

  // ### Methods
  Future<Paginator<ClubActivity>> findClubActivities(
    int pageSize,
    [ClubActivityCategory? category]
  ) async {
    Future<Page<ClubActivity>> pageRetriever(int page, int pageSize) async {
      final activities = category != null
        ? _clubActivitiesDummies.where((activity) => activity.category == category).toList()
        : _clubActivitiesDummies;

      final results = List.generate(pageSize, (index) {
        final randomIndex = Random().nextInt(activities.length);
        return activities[randomIndex];
      });

      return Page(
        content: results,
        pageInfo: PageInfo(
          size: pageSize,
          number: page,
          totalElements: pageSize * 4,
          totalPages: 4
        ),
      );
    }

    Future.delayed(Duration(seconds: 2));

    return Paginator.create(pageSize, pageRetriever);
  }

  Future<Paginator<User>> getClubMembers(int pageSize) {
    return _clubRepository.findClubMembers(pageSize, clubId);
  }

  Future<bool> isLoggedUserClubAdmin() async {
    checkClubLoaded();
    return club!.ownerId == (await _authViewModel.authData)!.user.id;
  }

  Future<Paginator<ReadingGoal>> getClubReadingGoals(int pageSize) async {
    return _readingGoalsRepository.findReadingGoalsByClubId(clubId, pageSize);
  }

  Future<Paginator<Meeting>> getClubMeetings(int pageSize) async {
    return _meetingsRepository.findMeetingsByClubId(clubId, pageSize);
  }

}