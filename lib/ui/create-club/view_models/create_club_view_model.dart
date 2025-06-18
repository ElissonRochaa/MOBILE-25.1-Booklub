import 'dart:io';
import 'dart:typed_data';
import 'package:booklub/domain/entities/clubs/club_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateClubViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepository authRepository;
  final ClubRepository clubRepository;
  final IORepository ioRepository;

  CreateClubViewModel({
    required this.ioRepository,
    required this.clubRepository,
    required this.authRepository,
  });

  String clubName = '';
  bool isPrivate = false;
  bool hasParticipantLimit = false;
  int? participantLimit;
  File? coverImage;

  void updateClubCoverImage(File coverImage) {
    coverImage = coverImage;
    notifyListeners();
  }

  void togglePrivacy() {
    isPrivate = !isPrivate;
    notifyListeners();
  }

  void toggleParticipantLimit(bool? value) {
    hasParticipantLimit = value ?? false;
    if (!hasParticipantLimit) participantLimit = null;
    notifyListeners();
  }

  void updateClubName(String name) {
    clubName = name;
    notifyListeners();
  }

  void updateParticipantLimit(String value) {
    participantLimit = int.tryParse(value);
    notifyListeners();
  }

  Future<void> pickCoverImage() async {
    final result = await ioRepository.pickImage();
    updateClubCoverImage(result!);
  }

  Future<bool> createClub() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    final authData = await authRepository.getAuthData();

    if (authData == null) {
      throw Exception('O usuário não está autenticado');
    }

    ClubCreationDTO dto = ClubCreationDTO(
      name: clubName,
      isPrivate: isPrivate.toString(),
      ownerId: authData.user.id,
      image: coverImage,
    );

    await clubRepository.createClub(dto);
    return true;
  }
}
