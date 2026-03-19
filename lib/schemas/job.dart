enum JobLocation {
  remote,
  onsite,
  hybrid;

  String get value => name.toUpperCase();
}

enum JobType {
  fullTime,
  partTime,
  contract,
  freelance,
  internship;

  String get value => name.toUpperCase();
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

  String get value {
    if (this == JobCategory.others) return 'ELSE';
    return name.toUpperCase();
  }
}

enum JobExperienceLevel {
  all,
  junior,
  mid,
  senior,
  noExperienceRequired;

  String get value => name.toUpperCase();
}

enum JobStatus {
  draft,
  paid,
  confirmed,
  hold,
  review,
  closed;

  String get value => name.toUpperCase();
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
