import 'package:booklub/domain/meetings/entities/meeting.dart';
import 'package:booklub/infra/meetings/meetings_repository.dart';

class MeetingViewModel {

  final MeetingsRepository _repository;

  MeetingViewModel({
    required MeetingsRepository repository,
  }) : _repository = repository;

  Future<Meeting?> getMeeting(String id) async {
    return _repository.findMeetingById(id);
  }

}