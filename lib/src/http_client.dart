import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final http.Client _httpClient;
  final String scheme;
  final String host;

  HttpClient({this.scheme = 'http', this.host, http.Client client})
      : _httpClient = client ?? http.Client();

  bool get _isHttps => scheme == 'https';

  Uri _makeUrl(String path, Map<String, String> query) =>
      _isHttps ? Uri.https(host, path, query) : Uri.http(host, path, query);

  Future<T> request<T>(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = _makeUrl(path, query);
    final response = await get(url, headers: headers);
    if (response.statusCode != 200) {
      throw response;
    }

    final body = response.body;

    if (body == null || body.isEmpty) {
      return null;
    }

    return json.decode(body);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _httpClient.send(request);
}
