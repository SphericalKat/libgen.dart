part of 'libgen.dart';

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
    @required String query,
    int count,
    int offset,
    SearchColumn searchIn,
  });

  Future<Book> getLatest();

  Future<int> getLatestId();

  Future<String> ping();
}
