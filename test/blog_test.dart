import 'dart:io';

import 'package:letit/letit.dart';
import 'package:test/test.dart';

void main() {
  final token = Platform.environment['LETIT_API_TOKEN'];

  test('Integration: List Admin Blogs', () async {
    if (token == null || token.isEmpty) {
      markTestSkipped('LETIT_API_TOKEN not set');
      return;
    }

    final client = LetItClient(
      apiKey: token,
      baseURL: 'https://api.letit.com',
    );

    final response = await client.blog.list(limit: 5, skip: 0);

    expect(response.totalList, greaterThanOrEqualTo(0));
    expect(response.totalPages, greaterThanOrEqualTo(0));
    expect(response.list.length, lessThanOrEqualTo(5));
  });

  test('Integration: Get Admin Blog By Slug', () async {
    if (token == null || token.isEmpty) {
      markTestSkipped('LETIT_API_TOKEN not set');
      return;
    }

    final client = LetItClient(
      apiKey: token,
      baseURL: 'https://api.letit.com',
    );

    final listResponse = await client.blog.list(limit: 1, skip: 0);
    if (listResponse.list.isEmpty) {
      markTestSkipped('No public admin blogs available');
      return;
    }

    final slug = listResponse.list.first.slug;
    final blog = await client.blog.getBySlug(slug: slug);

    expect(blog, isNotNull);
    expect(blog!.slug, equals(slug));
  });
}
