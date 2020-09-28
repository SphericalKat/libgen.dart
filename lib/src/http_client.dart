import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class HttpClient extends http.BaseClient {
  final http.Client _httpClient;
  final Uri baseUri;

  HttpClient({
    this.baseUri,
    http.Client client,
  }) : _httpClient = client ?? http.Client();

  /// Sends an HTTP GET request to [path] with the given [query] and [headers]
  Future<T> request<T>(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = baseUri?.replace(path: path, queryParameters: query);
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

  /// Sends an HTTP request and asynchronously returns the response.
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _httpClient.send(request);
}
