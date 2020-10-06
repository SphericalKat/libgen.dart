import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' hide get;
import 'package:meta/meta.dart';

import 'exceptions.dart';

@immutable
class HttpClient extends BaseClient {
  final Client _httpClient;
  final Uri baseUri;

  HttpClient({
    this.baseUri,
    Client client,
  }) : _httpClient = client ?? Client();

  /// Sends an HTTP GET request to [baseUri] with the
  /// required [path] and optional [query] and [headers]
  Future<T> request<T>(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final body = await requestRaw(path, query: query, headers: headers);

    if (body == null || body.isEmpty) {
      return null;
    }

    return json.decode(body);
  }

  /// Sends an HTTP GET request to [baseUri] with the
  /// required [path] and optional [query] and [headers]
  Future<String> requestRaw(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = baseUri?.replace(path: path, queryParameters: query);
    final response = await get(url, headers: headers);
    if (response.statusCode != 200) {
      throw HttpException(response);
    }

    final body = response.body;

    if (body == null || body.isEmpty) {
      return null;
    }

    return body;
  }

  /// Sends an HTTP request and asynchronously returns the response.
  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      _httpClient.send(request);
}
