import 'package:meta/meta.dart';

import 'constants.dart';
import 'http_client.dart';
import 'page_parser.dart';

@immutable
class LibgenApi {
  final HttpClient _client;

  LibgenApi({
    HttpClient client,
  }) : _client = client;

  /// Requests /json.php with [ids] and [searchFields]
  Future<List> json(List ids) => _client.request<List>('json.php', query: {
        'ids': ids.join(','),
        'fields': searchFields,
      });

  /// Requests /search.php with [query[
  Future<PageParser> search(Map<String, String> query) async {
    final body = await _client.requestRaw('search.php', query: query);
    return PageParser(body);
  }
}
