import 'package:meta/meta.dart';

import 'constants.dart';
import 'http_client.dart';
import 'list_extension.dart';
import 'mirror_finder.dart';
import 'mirror_schema.dart';
import 'mirrors.dart';
import 'models/book.dart';
import 'models/search.dart';
import 'parser.dart';
import 'util.dart';

@immutable
class Libgen extends _AbstactLibgen {
  final HttpClient _client;

  const Libgen({
    @required HttpClient client,
    MirrorOptions options = const MirrorOptions(),
  })  : _client = client,
        super(options: options);

  Libgen.fromSchema(MirrorSchema schema)
      : _client = HttpClient(baseUri: schema.baseUri),
        super(options: schema.options);

  static MirrorFinder get finder => MirrorFinder.fromSchemas(mirrorSchemas);

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with THE SHORTEST [ping] response
  static Future<Libgen> fastest() => finder.fastest();

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with ANY SUCCESSFUL [ping] response
  static Future<Libgen> any() => finder.any();

  /// Returns a [Book] by [id]
  /// Returns [Null] on no result
  @override
  Future<Book> getById(int id) async {
    final results = await getByIds([id]);
    return results.firstOrNull;
  }

  /// Returns a [List] of [Book] by [ids]
  @override
  Future<List<Book>> getByIds(List<int> ids) async {
    final results = await _client.request<List>('json.php',
        query: {'ids': ids.join(','), 'fields': searchFields});

    return results.map<Book>((item) => Book.fromJson(item)).toList();
  }

  @override
  Future<List<Book>> search({
    @required String text,
    int count = 25,
    int offset = 0,
    SearchSortBy sortBy,
    SearchColumn searchIn,
    bool reverse = false,
  }) async {
    final body = await _client.requestRaw('search.php', query: {
      'req': text,
      'view': 'simple',
      // 'page': 'page',
      'column': enumValue(searchIn),
      'sort': enumValue(sortBy),
      'sortmode': reverse ? 'DESC' : 'ASC',
      'res': getResultsCount(count).toString(),
    });

    final parser = LibgenPageParser(body);

    return getByIds(parser.ids);
  }

  /// Returns the latest [Book.id]
  @override
  Future<int> getLatestId() async {
    final body =
        await _client.requestRaw('search.php', query: {'mode': 'last'});
    final parser = LibgenPageParser(body);

    return parser.firstId;
  }

  /// Returns the latest [Book.md5]
  @override
  Future<Book> getLatest() async {
    final id = await getLatestId();

    if (id == null) {
      return null;
    }

    return getById(id);
  }

  /// Returns `"pong"` if the request succeeds
  ///
  /// Returns [Exception] if the request fails
  @override
  Future<String> ping() async {
    await getById(1);

    return 'pong';
  }
}

@immutable
abstract class _AbstactLibgen {
  final MirrorOptions _options;

  const _AbstactLibgen({
    MirrorOptions options,
  }) : _options = options;

  /// Returns the internal [_options.canDownload].
  bool get canDownload => _options.canDownload;

  Future<Book> getById(int id);

  Future<List<Book>> getByIds(List<int> id);

  Future<List<Book>> search({
    @required String text,
    int count = 25,
    int offset = 0,
    SearchSortBy sortBy,
    SearchColumn searchIn,
    bool reverse = false,
  });

  Future<Book> getLatest();

  Future<int> getLatestId();

  Future<String> ping();
}
