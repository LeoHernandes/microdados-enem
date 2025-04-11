import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AppHttpClient {
  final String _baseUrl;

  AppHttpClient() : this._baseUrl = dotenv.get('API_BASE_URL') + '/';

  Future<Map<String, dynamic>> get(String url, {Duration? timeout}) async {
    try {
      var request = http.get(Uri.parse(_baseUrl + url));
      if (timeout != null) request = request.timeout(timeout);

      final response = await request;
      final parsedReponse = _tryParseResponse(response);
      return parsedReponse;
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Future<Map<String, dynamic>> post(
    String url,
    Object body, {
    Duration? timeout,
  }) async {
    try {
      var request = http.post(
        Uri.parse(_baseUrl + url),
        body: jsonEncode(body),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
      );
      if (timeout != null) request = request.timeout(timeout);

      final response = await request;
      final parsedReponse = _tryParseResponse(response);
      return parsedReponse;
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  Map<String, dynamic> _tryParseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } else {
          return {};
        }
      case 404:
        throw Exception('Server not found');
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }
}
