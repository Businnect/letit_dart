import 'dart:convert';
import 'package:http/http.dart' as http;

import '../letit_dart.dart';
import '../schemas/job.dart';

class JobResource {
  JobResource(this._client);
  final LetItClient _client;

  Future<UserJobCreatedByUser> createWithCompany({
    required String companyName,
    required String companyDescription,
    required String companyWebsite,
    required String jobTitle,
    required String jobDescription,
    required String jobHowToApply,
    bool jobPayInCryptocurrency = false,
    FilePayload? companyLogo,
    String jobLocation = 'remote',
  }) async {
    final uri = Uri.parse('${_client.baseURL}/api/v1/client/job');
    final request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'company_name': companyName,
      'company_description': companyDescription,
      'company_website': companyWebsite,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_how_to_apply': jobHowToApply,
      'job_pay_in_cryptocurrency': jobPayInCryptocurrency.toString(),
      'job_location': jobLocation,
    });

    if (companyLogo != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'company_logo',
          companyLogo.bytes,
          filename: companyLogo.filename,
        ),
      );
    }

    final response = await _client.send(request);
    return UserJobCreatedByUser.fromJson(jsonDecode(response.body));
  }
}
