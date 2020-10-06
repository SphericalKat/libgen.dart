import 'package:libgen/src/models/book.dart';

final singleJsonList = [darkMatterBook.json];

final booksById = {
  -1: null,
  1: firstBook,
  1591104: darkMatterBook,
};

final darkMatterBook = _BookMock({
  'id': '1591104',
  'title': 'Dark Matter',
  'volumeinfo': '',
  'series': '',
  'periodical': '',
  'author': 'Blake Crouch',
  'year': '2016',
  'edition': '',
  'publisher': 'Crown',
  'city': '',
  'pages': '0',
  'language': 'English',
  'topic': '',
  'library': '',
  'issue': '0',
  'identifier': '9781101904237',
  'issn': '',
  'asin': '',
  'udc': '',
  'lbc': '',
  'ddc': '',
  'lcc': '',
  'doi': '',
  'googlebookid': '',
  'openlibraryid': '',
  'commentary': '',
  'dpi': '0',
  'color': '',
  'cleaned': '',
  'orientation': '',
  'paginated': '',
  'scanned': '',
  'bookmarked': '',
  'searchable': '',
  'filesize': '478322',
  'extension': 'epub',
  'md5': '7eabed69e5f2762211ec97ef972e8761',
  'generic': '',
  'visible': '',
  'locator': 'Dark Matter - Blake Crouch.epub',
  'local': '0',
  'timeadded': '2016-12-01 10:32:36',
  'timelastmodified': '2019-12-21 21:23:21',
  'coverurl': '1591000\/7eabed69e5f2762211ec97ef972e8761-g.jpg',
  'identifierwodash': '9781101904237',
  'tags': '',
  'pagesinfile': '0',
  'descr':
      'A mindbending, relentlessly surprising thriller from the author of the bestselling Wayward Pines trilogy-"Are you happy with your life?" Those are the last words Jason Dessen hears before the masked abductor knocks him unconscious. Before he awakens to find himself strapped to a gurney, surrounded by strangers in hazmat suits. Before a man Jason\'s never met smiles down at him and says, "Welcome back, my friend." In this world he\'s woken up to, Jason\'s life is not the one he knows. His wife is not his wife. His son was never born. And Jason is not an ordinary college physics professor, but a celebrated genius who has achieved something remarkable. Something impossible. Is it this world or the other that\'s the dream? And even if the home he remembers is real, how can Jason possibly make it back to the family he loves? The answers lie in a journey more wondrous and horrifying than anything he could\'ve imagined-one that will force him to confront the darkest parts of himself even as he battles a terrifying, seemingly unbeatable foe. Dark Matter is a brilliantly plotted tale that is at once sweeping and intimate, mind-bendingly strange and profoundly human-a relentlessly surprising science-fiction thriller about choices, paths not taken, and how far we\'ll go to claim the lives we dream of. From the Hardcover edition.',
  'toc': '',
  'sha1': 'B7PNQU2M2NAGWPU6RWZET4AHWOTJVFFO',
  'sha256': 'AEF0BDEFF001AE1937D542D987A5B50F1E188B8094DF777ED4377FB169E8A295',
  'crc32': '92BCB4FA',
  'edonkey': 'A3F48BCE8C942CAB907C43CEA7DE6F4E',
  'aich': 'YGQSMSV2SDEYWM6FRTLJQWXTZ4GJCE5T',
  'tth': 'GQ76I532APZPPJBIB75OYE75GYXTHWBFWS7U64I',
  'btih': '59933e2db4a2f6efbfbcde699d7eb3a33d04f116',
  'torrent':
      'ZDQ6aW5mb2Q2Omxlbmd0aGk0NzgzMjJlNDpuYW1lMzI6N2VhYmVkNjllNWYyNzYyMjExZWM5N2VmOTcyZTg3NjExMjpwaWVjZSBsZW5ndGhpMTY3NzcyMTZlNjpwaWVjZXMyMDoP3thTTNNAaz6ejbJJ8AezppqUrmVl'
});

final firstBook = _BookMock({
  'id': '1',
  'title': 'Handbook of Clinical Drug Data',
  'volumeinfo': '',
  'series': '',
  'periodical': '',
  'author': 'Philip Anderson',
  'year': '2001',
  'edition': '10',
  'publisher': 'McGraw-Hill Medical',
  'city': '',
  'pages': '1163',
  'language': 'English',
  'topic': '12',
  'library': 'Kolxo3',
  'issue': '17',
  'identifier': '0-07-136362-9',
  'issn': '',
  'asin': '',
  'udc': '',
  'lbc': '',
  'ddc': '',
  'lcc': '',
  'doi': '',
  'googlebookid': '',
  'openlibraryid': '',
  'commentary': '',
  'dpi': '0',
  'color': '',
  'cleaned': '',
  'orientation': '',
  'paginated': '',
  'scanned': '',
  'bookmarked': '',
  'searchable': '1',
  'filesize': '3627486',
  'extension': 'pdf',
  'md5': '7b2a4d53fde834e801c26a2bab7e0240',
  'generic': '',
  'visible': '',
  'locator':
      'B_Biology/Handbook of Clinical Drug Data (10th Edition)(1163s).pdf',
  'local': '0',
  'timeadded': '2009-07-20 03:45:11',
  'timelastmodified': '2019-12-21 21:23:21',
  'coverurl': '0/7b2a4d53fde834e801c26a2bab7e0240.jpg',
  'identifierwodash': '0071363629',
  'tags': '',
  'pagesinfile': '1163',
  'descr': null,
  'toc': null,
  'sha1': null,
  'sha256': null,
  'crc32': null,
  'edonkey': null,
  'aich': null,
  'tth': null,
  'btih': null,
  'torrent': null
});

class _BookMock {
  final Book object;
  final Map json;

  _BookMock(this.json) : object = Book.fromJson(json);

  int get id => object.id;

  @override
  String toString() => object.toString();
}
