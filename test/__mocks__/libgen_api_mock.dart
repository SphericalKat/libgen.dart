import 'package:libgen/src/libgen_api.dart';
import 'package:mockito/mockito.dart';

import 'book_mock.dart';

// ignore: must_be_immutable
class MockLibgenApi extends Mock implements LibgenApi {}

MockLibgenApi mockedLibgenApi() {
  final api = MockLibgenApi();
  mockLibgenJsonRequest(api);

  return api;
}

void mockLibgenJsonRequest(MockLibgenApi api) {
  when(api.getByIds(any)).thenAnswer((Invocation invocation) async =>
      invocation.positionalArguments.first
          .map<Map>((id) => booksById[id]?.json)
          .where((e) => e != null)
          .toList(growable: false));
}
