import 'dart:convert';
import 'package:http/http.dart' as http;

import 'resources/job.dart';
import 'resources/micropost.dart';

class LetItClient {
  LetItClient({
    required String baseURL,
    required this.apiKey,
    http.Client? httpClient,
  })  : baseURL = baseURL.endsWith('/')
            ? baseURL.substring(0, baseURL.length - 1)
            : baseURL,
        httpClient = httpClient ?? http.Client() {
    job = JobResource(this);
    micropost = MicropostResource(this);
  }
  final String baseURL;
  final String apiKey;
  final http.Client httpClient;

  late final JobResource job;
  late final MicropostResource micropost;

  Future<http.Response> send(http.BaseRequest request) async {
    request.headers['USER-API-TOKEN'] = apiKey;
    request.headers['User-Agent'] = 'LetIt-Go-SDK/1.0';

    final streamedResponse = await httpClient.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 400) {
      String message = 'api error: status ${response.statusCode}';
      try {
        final body = jsonDecode(response.body);
        if (body['detail'] != null) message = 'api error: ${body['detail']}';
      } catch (_) {}
      throw Exception(message);
    }

    return response;
  }
}
