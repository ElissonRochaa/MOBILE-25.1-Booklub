import 'package:booklub/infra/auth/auth_repository.dart';
import 'package:booklub/utils/validation/input_validators.dart';
import 'package:booklub/utils/validation/input_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class RecoverPasswordViewModel extends ChangeNotifier {

  final log = Logger();

  final AuthRepository authRepository;

  final InputValidators inputValidators;

  late final InputWrapper usernameInput;

  RecoverPasswordViewModel({
    required this.authRepository,
    required this.inputValidators
  }) {
    usernameInput = InputWrapper(
      controller: TextEditingController(),
      validator: inputValidators.validateBasicTextField,
    );
    usernameInput.addListener(notifyListeners);

  }

  Future<bool> sendResetPasswordEmail() async {
    final inputs = [usernameInput];

    final invalidInputs = inputs.where((input) => !input.isValid);

    if (invalidInputs.isNotEmpty) {
      log.d('Invalid inputs: $invalidInputs');
      return false;
    }

    await authRepository.recoverPasswordViaEmail(
      usernameInput.text,
    );

    log.d('Envio de e-mail realizado com sucesso!');
    return true;
  }

}