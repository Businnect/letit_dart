enum PostType {
  text,
  media;

  String get value => name.toUpperCase();
}

class MicropostVoteResponse {
  MicropostVoteResponse({required this.userVoted});

  factory MicropostVoteResponse.fromJson(Map<String, dynamic> json) {
    return MicropostVoteResponse(
      userVoted: json['user_voted'] ?? false,
    );
  }

  final bool userVoted;
}
