import 'dart:convert';
import 'package:http/http.dart' as http;

import '../letit.dart';
import '../schemas/schemas.dart';

class BlogResource {
  BlogResource(this._client);
  final LetItClient _client;

  Future<AdminBlogItem?> getBySlug({required String slug}) async {
    final uri = Uri.parse('${_client.baseURL}/api/v1/client/admin/blog')
        .replace(queryParameters: {'slug': slug});

    final request = http.Request('GET', uri);
    final response = await _client.send(request);

    final json = jsonDecode(response.body);
    if (json == null) return null;

    return AdminBlogItem.fromJson(json as Map<String, dynamic>);
  }

  Future<AdminBlogListResponse> list({
    String? title,
    String? category,
    int? skip,
    int? limit,
  }) async {
    final query = <String, String>{
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (skip != null) 'skip': skip.toString(),
      if (limit != null) 'limit': limit.toString(),
    };

    final baseUri = Uri.parse('${_client.baseURL}/api/v1/client/admin/blog/list');
    final uri = query.isEmpty
        ? baseUri
        : baseUri.replace(queryParameters: query);

    final request = http.Request('GET', uri);
    final response = await _client.send(request);

    return AdminBlogListResponse.fromJson(jsonDecode(response.body));
  }
}