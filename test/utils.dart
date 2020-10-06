import 'dart:io';

import 'package:libgen/src/http_client.dart';
import 'package:mockito/mockito.dart';

import '__mocks__/book_mock.dart';

// ignore: must_be_immutable
class MockHttpClient extends Mock implements HttpClient {}

MockHttpClient defaultMockedClient() {
  final client = MockHttpClient();
  when(client.request<List>('json.php', query: anyNamed('query'))).thenAnswer(
      (Invocation invocation) async => invocation
          .named('query')['ids']
          .split(',')
          .map<Map>((id) => booksById[int.parse(id)]?.json)
          .where((e) => e != null)
          .toList(growable: false));

  return client;
}

extension _InvocationArguments on Invocation {
  dynamic named(String name) => namedArguments[Symbol(name)];
}

Future<String> fileContents(String path) async =>
    await File(path).readAsString();
