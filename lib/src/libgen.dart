import 'package:meta/meta.dart';

import 'http_client.dart';
import 'libgen_api.dart';
import 'list_extension.dart';
import 'mirror_finder.dart';
import 'mirror_schema.dart';
import 'mirrors.dart';
import 'models/book.dart';
import 'models/search.dart';
import 'search/libgen_search.dart';
import 'util.dart';

@immutable
class Libgen extends _AbstactLibgen {
  final LibgenApi _api;

  Libgen({
    HttpClient client,
    MirrorOptions options = const MirrorOptions(),
  })  : _api = LibgenApi(
          client: client ?? HttpClient(baseUri: mirrorSchemas.first.baseUri),
        ),
        super(options: options);

  Libgen.fromSchema(MirrorSchema schema)
      : _api = LibgenApi(client: HttpClient(baseUri: schema.baseUri)),
        super(options: schema.options);

  static MirrorFinder get finder => MirrorFinder.fromSchemas(mirrorSchemas);

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with THE SHORTEST [ping] response
  static Future<Libgen> fastest() => finder.fastest();

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with ANY SUCCESSFUL [ping] response
  static Future<Libgen> any() => finder.any();

  /// Returns a [Book] by [id] or [Null] on no result
  @override
  Future<Book> getById(int id) async {
    if (id == null) {
      return null;
    }

    final results = await getByIds([id]);
    return results.firstOrNull;
  }

  /// Returns a [List] of [Book] by [ids]
  @override
  Future<List<Book>> getByIds(List<int> ids) async {
    final list = <Book>[];
    final results = await _api.json(ids);
    final byId = results.fold<Map<int, Book>>({}, (acc, item) {
      acc[int.parse(item['id'])] = Book.fromJson(item);

      return acc;
    });

    ids.forEach((element) {
      final item = byId[element];
      if (item != null) {
        list.add(item);
      }
    });

    return list;
  }

  @override
  Future<List<Book>> search({
    @required String text,
    int count = 25,
    int offset = 0,
    SearchColumn searchIn,
  }) async {
    final libgenSearch = LibgenSearch(
      text: text,
      count: count,
      offset: offset,
      searchIn: enumValue(searchIn),
    );
    final ids = await libgenSearch.run(_api.search);

    return getByIds(ids);
  }

  /// Returns the latest [Book.id]
  @override
  Future<int> getLatestId() async {
    final data = await _api.search({'mode': 'last'});

    return data.firstId;
  }

  /// Returns the latest [Book]
  @override
  Future<Book> getLatest() => getLatestId().then(getById);

  /// Returns `"pong"` if the request succeeds
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
    int count,
    int offset,
    SearchColumn searchIn,
  });

  Future<Book> getLatest();

  Future<int> getLatestId();

  Future<String> ping();
}
