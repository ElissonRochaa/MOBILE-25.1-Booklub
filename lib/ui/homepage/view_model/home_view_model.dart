import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/activities/activities_repository.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';

class HomePayload {
  final List<Club> myClubs;
  final List<Activity> recentActivities;

  HomePayload({required this.myClubs, required this.recentActivities});
}

class HomeViewModel extends AsyncChangeNotifier<HomePayload> {
  final ClubRepository clubRepository;
  final AuthRepository authRepository;
  final ActivitiesRepository activitiesRepository;

  HomeViewModel({
    required this.clubRepository,
    required this.authRepository,
    required this.activitiesRepository,
  }) {
    _loadData();
  }

  @override
  HomePayload? get payload => _payload;
  HomePayload? _payload;

  Future<void> _loadData() async {
    isLoading = true;
    notifyListeners();

    try {
      final authData = await authRepository.getAuthData();
      final userId = authData?.user.id;

      if (userId == null) {
        throw Exception('Usuário não autenticado');
      }

      final clubsPaginator = await clubRepository.findClubsByUserId(10, userId);
      final clubsFirstPage = await clubsPaginator[0];
      final myClubs = clubsFirstPage.content;

      final activitiesPaginator = await activitiesRepository
          .findActivitiesForUser(userId, 5);
      final activitiesFirstPage = await activitiesPaginator[0];
      final recentActivities = activitiesFirstPage.content;

      _payload = HomePayload(
        myClubs: myClubs,
        recentActivities: recentActivities,
      );
      error = null;
    } catch (e, stack) {
      error = (object: e, stackTrace: stack);
      _payload = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Paginator<Activity>> getRecentActivitiesPaginator() async {
    final authData = await authRepository.getAuthData();
    final userId = authData?.user.id;

    if (userId == null) throw Exception('Usuário não autenticado');

    return activitiesRepository.findActivitiesForUser(userId, 5);
  }
}
