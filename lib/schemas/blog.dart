class AdminBlogListResponse {
  AdminBlogListResponse({
    required this.list,
    required this.totalList,
    required this.totalPages,
  });

  factory AdminBlogListResponse.fromJson(Map<String, dynamic> json) {
    return AdminBlogListResponse(
      list: (json['list'] as List<dynamic>? ?? <dynamic>[])
          .map((entry) => AdminBlogItem.fromJson(entry as Map<String, dynamic>))
          .toList(),
      totalList: (json['total_list'] as num?)?.toInt() ?? 0,
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
    );
  }

  final List<AdminBlogItem> list;
  final int totalList;
  final int totalPages;
}

class AdminBlogItem {
  AdminBlogItem({
    required this.body,
    required this.category,
    required this.cover,
    required this.isFeatured,
    required this.publishedAt,
    required this.slug,
    required this.summary,
    required this.title,
  });

  factory AdminBlogItem.fromJson(Map<String, dynamic> json) {
    return AdminBlogItem(
      body: json['body'] ?? '',
      category: json['category'] ?? '',
      cover: json['cover'] ?? '',
      isFeatured: json['is_featured'] ?? false,
      publishedAt: DateTime.tryParse(json['published_at'] ?? ''),
      slug: json['slug'] ?? '',
      summary: json['summary'] ?? '',
      title: json['title'] ?? '',
    );
  }

  final String body;
  final String category;
  final String cover;
  final bool isFeatured;
  final DateTime? publishedAt;
  final String slug;
  final String summary;
  final String title;
}