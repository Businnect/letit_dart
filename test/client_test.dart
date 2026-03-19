import 'package:test/test.dart';
import 'package:letit_dart/letit_dart.dart';

void main() {
  group('LetItClient Errors', () {
    test('Invalid API Token 401', () async {
      final client = LetItClient(
        apiKey: 'fake-key',
        baseURL: 'https://api.letit.com',
      );

      expect(
        () async => await client.micropost.create(
          body: 'Hello',
          title: 'Test',
        ),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('USER-API-TOKEN header is not valid'),
          ),
        ),
      );
    });
  });
}
