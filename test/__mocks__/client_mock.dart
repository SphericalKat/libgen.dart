import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:mockito/mockito.dart';

// import 'package:test/test.dart';
class MockClient extends Mock implements Client {}

MockClient mockedClientWithResponse(String response, [int statusCode = 200]) {
  final client = MockClient();
  final string =
      response is String ? response : JsonEncoder().convert(response);
  when(client.get(any)).thenAnswer((_) async => Response(string, statusCode));

  return client;
}
