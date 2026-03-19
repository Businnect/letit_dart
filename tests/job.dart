import 'dart:io';
import 'package:letit_dart/letit_dart.dart';
import 'package:test/test.dart';

import 'package:letit_dart/schemas/schemas.dart';


void main() {
  final token = Platform.environment['LETIT_API_TOKEN'];

  test('Integration: Create and Delete Job with Company', () async {
    if (token == null || token.isEmpty) {
      markTestSkipped('LETIT_API_TOKEN not set');
      return;
    }

    final client = LetItClient(
      apiKey: token,
      baseURL: 'https://api.letit.com',
    );

    final logoFile = File('test/assets/logo.png');
    if (!await logoFile.exists()) {
      fail('Test logo not found at test/assets/logo.png');
    }

    final filePayload = FilePayload(
      filename: 'logo.png',
      bytes: await logoFile.readAsBytes(),
      mimeType: 'image/png',
    );

    final response = await client.job.createWithCompany(
      companyName: 'LetIt Go Dart SDK Test',
      companyDescription: 'Professional Dart SDK integration test.',
      companyWebsite: 'https://letit.com',
      jobTitle: 'Software Engineer (Dart/Flutter)',
      jobDescription: 'Developing mobile apps with Dart.',
      jobHowToApply: 'https://letit.com/apply',
      companyLogo: filePayload,
    );

    expect(response.slug, isNotEmpty);

    try {

      await client.job.delete(response.slug); 
      print('Successfully cleaned up job: ${response.slug}');
    } catch (e) {
      print('Warning: Failed to cleanup job ${response.slug}: $e');
    }
  });
}