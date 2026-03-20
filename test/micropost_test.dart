import 'dart:io';
import 'package:test/test.dart';

import 'package:letit_dart/letit_dart.dart';
import 'package:letit_dart/schemas/schemas.dart';

void main() {
  final token = Platform.environment['LETIT_API_TOKEN'];

  test('Integration: Create and Delete Micropost', () async {
    if (token == null || token.isEmpty) {
      markTestSkipped('LETIT_API_TOKEN not set');
      return;
    }

    final client = LetItClient(
      apiKey: token,
      baseURL: 'https://api.letit.com',
    );

    final response = await client.micropost.create(
      body: 'Hello from Dart SDK',
      title: 'Test Dart',
      postType: PostType.text,
    );

    expect(response.publicId, isNotEmpty);

    try {
      await client.micropost.delete(response.publicId);
      print('Successfully cleaned up micropost: ${response.publicId}');
    } catch (e) {
      fail('Failed to cleanup micropost: $e');
    }
  });
}
