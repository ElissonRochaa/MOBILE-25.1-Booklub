import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/entities/users/user.dart';
import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/infra/activities/activities_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/meetings/meetings_repository.dart';
import 'package:booklub/infra/reading_goals/reading_goals_repository.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:booklub/ui/core/view_models/auth_view_model.dart';
import 'package:booklub/utils/pagination/paginator.dart';

class ClubProfileViewModel extends AsyncChangeNotifier {

  // ### Dependencies
  final ClubRepository _clubRepository;

  final ReadingGoalsRepository _readingGoalsRepository;

  final MeetingsRepository _meetingsRepository;

  final ActivitiesRepository _activitiesRepository;

  final AuthViewModel _authViewModel;

  final String clubId;

  // ### Constructors
  ClubProfileViewModel({
    required ClubRepository clubRepository,
    required ReadingGoalsRepository readingGoalsRepository,
    required MeetingsRepository meetingsRepository,
    required ActivitiesRepository activityRepository,
    required AuthViewModel authViewModel,
    required this.clubId,
  }):
    _clubRepository = clubRepository,
    _readingGoalsRepository = readingGoalsRepository,
    _meetingsRepository = meetingsRepository,
    _activitiesRepository = activityRepository,
    _authViewModel = authViewModel
  {
    _setClub(clubId);
  }

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

  Future<Paginator<Activity>> getClubActivities(int pageSize) async {
    return _activitiesRepository.findActivitiesByClubId(clubId, pageSize);
  }

}