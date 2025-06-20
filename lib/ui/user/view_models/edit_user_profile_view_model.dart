import 'dart:io';
import 'package:booklub/domain/entities/users/user_update_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:booklub/infra/user/user_repository.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class EditUserProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final IORepository ioRepository;
  final InputValidators inputValidators;

  final Logger log = Logger();

  late ValueNotifier<File?> profilePicture;
  late InputWrapper firstNameInput;
  late InputWrapper lastNameInput;
  late InputWrapper birthDateInput;

  EditUserProfileViewModel({
    required this.userRepository,
    required this.authRepository,
    required this.inputValidators,
    required this.ioRepository,
  }) {
    profilePicture = ValueNotifier(null);
    profilePicture.addListener(notifyListeners);

    firstNameInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    firstNameInput.addListener(notifyListeners);

    lastNameInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    lastNameInput.addListener(notifyListeners);

    birthDateInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    birthDateInput.addListener(notifyListeners);

    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final authData = await authRepository.getAuthData();

    if (authData != null) {
      final user = authData.user;

      firstNameInput.text = user.firstName;
      lastNameInput.text = user.lastName;

      notifyListeners();
    }
  }

  Future<void> pickProfilePicture() async {
    profilePicture.value = await ioRepository.pickImage();
  }

  Future<bool> update() async {
    final inputs = [
      firstNameInput,
      lastNameInput,
      birthDateInput,
    ];

    final invalidInputs = inputs.where((input) => !input.isValid);

    if (invalidInputs.isNotEmpty) {
      log.d("Invalid inputs: $invalidInputs");
      return false;
    }

    final authData = await authRepository.getAuthData();

    if (authData == null) {
      log.d("Usuário não logado");
      return false;
    }

    final dto = UserUpdateDTO(
      id: authData.user.id,
      firstName: firstNameInput.text,
      lastName: lastNameInput.text,
      image: profilePicture.value,
    );

    log.d("Updating user with DTO: $dto");

    await userRepository.update(dto);
    return true;
  }
}
