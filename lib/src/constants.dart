import 'models/book.dart';

String get searchFields => Book(id: 0, md5: '').toJson().keys.join(',');
