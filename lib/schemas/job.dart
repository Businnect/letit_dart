import 'dart:typed_data';

enum JobLocation {
  remote,
  onsite,
  hybrid;

  String get jsonValue => name.toUpperCase();
}

enum JobType {
  fullTime,
  partTime,
  contract,
  freelance,
  internship;

  String get jsonValue => name.toUpperCase();
}

enum JobCategory {
  programming,
  blockchain,
  design,
  marketing,
  customerSupport,
  writing,
  product,
  service,
  humanResource,
  others;

  String get jsonValue => name.toUpperCase();
}

enum JobExperienceLevel {
  all,
  junior,
  mid,
  senior,
  noExperienceRequired;

  String get jsonValue => name.toUpperCase();
}

enum JobStatus {
  draft,
  paid,
  confirmed,
  hold,
  review,
  closed;

  String get jsonValue => name.toUpperCase();
}

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

class UserJobCreatedByUser {
  UserJobCreatedByUser({required this.slug});

  factory UserJobCreatedByUser.fromJson(Map<String, dynamic> json) {
    return UserJobCreatedByUser(
      slug: json['slug'] ?? '',
    );
  }
  final String slug;
}
