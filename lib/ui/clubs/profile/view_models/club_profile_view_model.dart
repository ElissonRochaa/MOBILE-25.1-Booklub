import 'dart:math';

import 'package:booklub/domain/entities/clubs/activities/club_activity.dart';
import 'package:booklub/domain/entities/clubs/activities/completed_reading.dart';
import 'package:booklub/domain/entities/clubs/activities/new_meeting.dart';
import 'package:booklub/domain/entities/clubs/activities/reading_goal.dart';
import 'package:booklub/domain/entities/clubs/club.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/utils/pagination/page.dart';
import 'package:booklub/utils/pagination/paginator.dart';
import 'package:flutter/material.dart' hide Page;

class ClubProfileViewModel extends ChangeNotifier {

  final ClubRepository _clubRepository;
  
  final List<ClubActivity> _clubActivitiesDummies = [
    ReadingGoal(
      clubId: 'club123',
      bookId: 'book456',
      startDate: DateTime(2023, 1, 15),
      finishDate: DateTime(2023, 2, 28)
    ),
    NewMeeting(
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
    ReadingGoal(
      clubId: 'clubXYZ',
      bookId: 'bookDEF',
      startDate: DateTime(2023, 4, 1),
      finishDate: DateTime(2023, 5, 15),
    ),
    NewMeeting(
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

  ClubProfileViewModel({
    required ClubRepository clubRepository
  }): _clubRepository = clubRepository;

  Future<Club> findClubById(String clubId) async {
    return _clubRepository.findClubById(clubId);
  }

  Future<Paginator<Club>> findClubs(int pageSize) async {
    return _clubRepository.findClubs(pageSize);
  }

  Future<Paginator<ClubActivity>> findClubActivities(
    String clubId,
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

}