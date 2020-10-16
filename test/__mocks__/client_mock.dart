import 'package:http/http.dart' show Client, Response;
import 'package:mockito/mockito.dart';

// import 'package:test/test.dart';
class MockClient extends Mock implements Client {}

MockClient mockedClientWithResponse(String response, [int statusCode = 200]) {
  final client = MockClient();
  when(client.get(any))
      .thenAnswer((_) async => Response(response ?? 'null', statusCode));

  return client;
}
