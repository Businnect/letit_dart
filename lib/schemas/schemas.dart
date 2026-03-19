import 'dart:typed_data';

export 'job.dart';
export 'common.dart';
export 'micropost.dart';

class FilePayload {
  FilePayload({
    required this.filename,
    required this.bytes,
    this.mimeType,
  });

  final String filename;
  final Uint8List bytes;
  final String? mimeType;
}