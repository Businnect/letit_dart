import 'dart:convert';
import 'package:http/http.dart' as http;

import '../letit_dart.dart';
import '../schemas/schemas.dart';

class MicropostResource {
  MicropostResource(this._client);
  final LetItClient _client;

  Future<CreatedWithPublicIdAndLink> create({
    required String body,
    String? title,
    PostType postType = PostType.text,
    bool allowComments = true,
    bool isDraft = false,
    FilePayload? file,
  }) async {
    final uri = Uri.parse('${_client.baseURL}/api/v1/client/micropost');
    final request = http.MultipartRequest('POST', uri);

    request.fields['body'] = body;
    request.fields['post_type'] = postType.value;
    request.fields['allow_comments'] = allowComments.toString();
    request.fields['is_draft'] = isDraft.toString();

    if (title != null) request.fields['title'] = title;

    if (file != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file.bytes,
          filename: file.filename,
        ),
      );
    }

    final response = await _client.send(request);
    return CreatedWithPublicIdAndLink.fromJson(
      jsonDecode(response.body),
    );
  }

  Future<void> delete(String publicId) async {
    final uri = Uri.parse('${_client.baseURL}/api/v1/client/micropost');
    final request = http.Request('DELETE', uri);
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode({'public_id': publicId});

    await _client.send(request);
  }
}
