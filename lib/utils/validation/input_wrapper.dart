import 'package:booklub/utils/validation/input_validator.dart';
import 'package:flutter/cupertino.dart';

class InputWrapper extends ChangeNotifier implements TextEditingController {

  bool _isValid = false;

  String? _errorMessage;

  InputValidator validator;

  TextEditingController controller;

  InputWrapper({
    required this.validator,
    required this.controller,
  }) {
    controller.addListener(() {
      final errorMessage = validator(text);
      _isValid = errorMessage == null;
      _errorMessage = errorMessage;
      notifyListeners();
    });
  }

  bool get isValid => _isValid;

  String? get errorMessage => _errorMessage;

  @override
  TextSelection get selection => controller.selection;

  @override
  set selection(TextSelection newSelection) => controller.selection = newSelection;

  @override
  String get text => controller.text;

  @override
  set text(String newText) => controller.text = newText;

  @override
  TextEditingValue get value => controller.value;

  @override
  set value(TextEditingValue newValue) => controller.value = newValue;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing
  }) => controller.buildTextSpan(
    context: context,
    withComposing: withComposing,
    style: style
  );

  @override
  void clear() => controller.clear();

  @override
  void clearComposing() => controller.clearComposing();

  @override
  void addListener(VoidCallback callback) {
    controller.addListener(callback);
  }

  @override
  void removeListener(VoidCallback callback) {
    controller.removeListener(callback);
  }

}