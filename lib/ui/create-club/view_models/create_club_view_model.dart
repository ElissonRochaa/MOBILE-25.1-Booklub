import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateClubViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String clubName = '';
  bool isPrivate = false;
  bool hasParticipantLimit = false;
  int? participantLimit;
  Uint8List? coverImage;

  void updateClubCoverImageBytes(Uint8List coverImageBytes) {
    coverImage = coverImageBytes;
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
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      coverImage = result.files.single.bytes;
      notifyListeners();
    }
  }

  void submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      //api aqui
    }
  }
}
