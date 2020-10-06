import 'package:http/http.dart' show Response;

class HttpException implements Exception {
  final Response response;

  HttpException([this.response]);
}

class NoAvailableMirrorException implements Exception {
  final String message = 'No mirror is available.';

  NoAvailableMirrorException();
}

// class NoResultsException implements Exception {
//   factory NoResultsException() => Exception('Search did not return any results');
// }
