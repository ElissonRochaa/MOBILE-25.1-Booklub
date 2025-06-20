import 'dart:io';

import 'package:booklub/domain/entities/clubs/club_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/clubs/club_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:booklub/ui/core/view_models/async_change_notifier.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CreateClubViewModel extends AsyncChangeNotifier<void> {

  // ### Dependencies
  final Logger log = Logger(printer: SimplePrinter());

  final AuthRepository authRepository;

  final ClubRepository clubRepository;

  final IORepository ioRepository;

  final InputValidators inputValidators = InputValidators();

  // ### Fields
  late final ValueNotifier<File?> clubImage;

  late final InputWrapper nameInput;

  late final ValueNotifier<bool> isPrivate;

  // ### State
  @override
  void get payload {
    return;
  }

  bool created = false;

  CreateClubViewModel({
    required this.ioRepository,
    required this.clubRepository,
    required this.authRepository,
  }) {
    clubImage = ValueNotifier(null);
    clubImage.addListener(notifyListeners);

    nameInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    nameInput.addListener(notifyListeners);

    isPrivate = ValueNotifier(false);
    isPrivate.addListener(notifyListeners);
  }

  void updateClubCoverImage(File coverImage) {
    coverImage = coverImage;
    notifyListeners();
  }

  void togglePrivacy() => isPrivate.value = !isPrivate.value;

  Future<void> picklubImage() async {
    clubImage.value = await ioRepository.pickImage();
  }

  Future<bool> createClub() async {
    final authData = await authRepository.getAuthData();
    if (authData == null) throw Exception('O usuário não está autenticado');

    super.isLoading = true;
    notifyListeners();

    final bool completed;

    if (nameInput.isValid) {
      await clubRepository.createClub(ClubCreationDTO(
        name: nameInput.text,
        isPrivate: isPrivate.value,
        ownerId: authData.user.id,
        image: clubImage.value,
      ));
      completed = true;
    } else {
      log.d('Invalid name input!');
      completed = false;
    }

    super.isLoading = false;
    notifyListeners();
    created = true;

    return completed;
  }

}
