import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AppHttpClient {
  final String _baseUrl;

  AppHttpClient() : this._baseUrl = dotenv.get('API_BASE_URL') + '/';

  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.body) as Map<String, dynamic>;
        case 404:
          throw Exception('Server not found');
        case 500:
          throw Exception('Internal server error');
        default:
          throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
