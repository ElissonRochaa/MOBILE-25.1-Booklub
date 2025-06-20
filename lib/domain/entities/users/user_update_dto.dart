import 'dart:io';

import 'package:booklub/utils/http/http_utils.dart';
import 'package:http/http.dart' as http;

class UserUpdateDTO {

  final String id;

  final String? firstName;

  final String? lastName;

  final File? image;

  UserUpdateDTO({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  Future<void> fillMultipartRequest(http.MultipartRequest request) async {
    request.fields['id'] = id;
    request.fields['firstName'] = firstName!;
    request.fields['lastName'] = lastName!;


    if (image != null && HttpUtils.isImage(image!)) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path,
        contentType: HttpUtils.resolveMediaType(image!)
      ));
    }
  }

}