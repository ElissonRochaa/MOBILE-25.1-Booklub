import 'package:booklub/domain/activities/entities/activity.dart';
import 'package:booklub/infra/activities/activities_repository.dart';

class ActivityViewModel {

  final ActivitiesRepository _activitiesRepository;

  ActivityViewModel({
    required ActivitiesRepository activitiesRepository,
  }) : _activitiesRepository = activitiesRepository;

  Future<Activity> getActivity(String id) async {
    return _activitiesRepository.findById(id);
  }

}