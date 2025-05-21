import 'dart:io';
import 'package:http/http.dart' as http;

class UserCreationDTO {

  final String username;

  final String email;

  final String firstName;

  final String lastName;

  final File? image;

  final String password;

  UserCreationDTO({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.image,
    required this.password,
  });

  void fillMultipartRequest(http.MultipartRequest request) async {
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['password'] = password;
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path
      ));
    }
  }

}