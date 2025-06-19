import 'package:booklub/domain/reading_goals/entities/reading_goal.dart';
import 'package:booklub/infra/reading_goals/reading_goals_repository.dart';

class ReadingGoalViewModel {

  final ReadingGoalsRepository _readingGoalsRepository;

  ReadingGoalViewModel({
    required ReadingGoalsRepository readingGoalsRepository,
  }): _readingGoalsRepository = readingGoalsRepository;

  Future<ReadingGoal?> findById(String id) async {
    return _readingGoalsRepository.findById(id);
  }

}