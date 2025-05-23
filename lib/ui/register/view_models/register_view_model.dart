import 'dart:io';
import 'package:booklub/domain/entities/users/user_creation_dto.dart';
import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/infra/io/io_repository.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RegisterViewModel extends ChangeNotifier {

  final AuthRepository authRepository;

  final IORepository ioRepository;

  final InputValidators inputValidators;

  final Logger log = Logger();

  late ValueNotifier<File?> profilePicture;

  late InputWrapper firstNameInput;

  late InputWrapper lastNameInput;

  late InputWrapper usernameInput;

  late InputWrapper birthDateInput;

  late InputWrapper emailInput;

  late InputWrapper passwordInput;

  RegisterViewModel({
    required this.authRepository,
    required this.inputValidators,
    required this.ioRepository
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

    usernameInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    usernameInput.addListener(notifyListeners);

    birthDateInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    birthDateInput.addListener(notifyListeners);

    emailInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateEmail,
    );
    emailInput.addListener(notifyListeners);

    passwordInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validatePassword,
    );
    passwordInput.addListener(notifyListeners);
  }

  Future<void> register() async {
    final inputs = [
      firstNameInput,
      lastNameInput,
      usernameInput,
      birthDateInput,
      emailInput,
      passwordInput,
    ];

    print('Registering');

    final invalidInputs = inputs.where((input) => !input.isValid);

    if (invalidInputs.isNotEmpty) {
      log.d(invalidInputs);
      return;
    }

    final dto = UserCreationDTO(
      username: usernameInput.text,
      email: emailInput.text,
      firstName: firstNameInput.text,
      lastName: lastNameInput.text,
      password: passwordInput.text,
      image: profilePicture.value,
    );

    await authRepository.register(dto);
  }

  Future<void> pickProfilePicture() async {
    profilePicture.value = await ioRepository.pickImage();
  }

}
