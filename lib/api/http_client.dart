import 'dart:io';
import 'package:http/http.dart' as http;

class MyHttpClient {
  static const baseUrl = "http://172.16.0.13:3000";

  static Future<http.Response> get({
    required String url,
  }) async {
    final response = await http.get(
      Uri.parse(baseUrl + url),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    return response;
  }
}
