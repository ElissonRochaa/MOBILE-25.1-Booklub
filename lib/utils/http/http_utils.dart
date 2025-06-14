import 'dart:io';

import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:mime/mime.dart';

abstract final class HttpUtils {

  static MediaType resolveMediaType(File file) {
    final imageMimeType = lookupMimeType(file.path)
        ?? 'application/octet-stream';
    final parts = imageMimeType.split('/');
    return MediaType(parts[0], parts[1]);
  }

  static bool isImage(File file) {
    final mediaType = resolveMediaType(file);
    return mediaType.type == 'image';
  }

}