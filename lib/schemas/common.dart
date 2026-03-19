class CreatedWithPublicIdAndLink {

  CreatedWithPublicIdAndLink({
    required this.publicId,
    required this.link,
  });

  factory CreatedWithPublicIdAndLink.fromJson(Map<String, dynamic> json) {
    return CreatedWithPublicIdAndLink(
      publicId: json['public_id'] ?? '',
      link: json['link'] ?? '',
    );
  }
  final String publicId;
  final String link;
}