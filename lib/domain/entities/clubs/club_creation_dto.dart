import 'dart:io';
import 'package:http/http.dart' as http;

class ClubCreationDTO {

  final String name;

  final String ownerId;

  final File? image;

  final String isPrivate;

  ClubCreationDTO({
    required this.name,
    required this.isPrivate,
    required this.ownerId,
    this.image,
  });

  Future<void> fillMultipartRequest(http.MultipartRequest request) async {
    request.fields['name'] = name;
    request.fields['isPrivate'] = isPrivate;
    request.fields['ownerId'] = ownerId;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path
      ));
    }


  }

}