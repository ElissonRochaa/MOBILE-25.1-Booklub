

class InputValidators {

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "O campo de senha não pode ser vázio!";
    } else if (password.length < 6) {
      return "A senha deve ter mais de 6 carácteres";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'O campo de e-mail não pode ser vázio!';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'E-mail inválido!';
    }

    return null;
  }

  String? validateBasicTextField(String? text) {
    if (text == null || text.isEmpty) {
      return 'Preencha este campo!';
    }
    return null;
  }

  String? validateEditableField(String originalValue, String newValue) {
    if (originalValue == newValue) {
      return 'Esse campo não foi atualizado!';
    }
    return null;
  }

}