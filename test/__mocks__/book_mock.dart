import 'package:libgen/src/models/book.dart';

final booksById = {
  -1: null,
  1: firstBook,
  1591104: darkMatterBook,
};

final darkMatterBook = _BookMock({
  'id': '1591104',
  'md5': '7eabed69e5f2762211ec97ef972e8761',
  'title': 'Dark Matter',
  'author': 'Blake Crouch',
  'year': '2016',
  'edition': '',
  'publisher': 'Crown',
  'language': 'English',
  'descr':
      'A mindbending, relentlessly surprising thriller from the author of the bestselling Wayward Pines trilogy-"Are you happy with your life?" Those are the last words Jason Dessen hears before the masked abductor knocks him unconscious. Before he awakens to find himself strapped to a gurney, surrounded by strangers in hazmat suits. Before a man Jason\'s never met smiles down at him and says, "Welcome back, my friend." In this world he\'s woken up to, Jason\'s life is not the one he knows. His wife is not his wife. His son was never born. And Jason is not an ordinary college physics professor, but a celebrated genius who has achieved something remarkable. Something impossible. Is it this world or the other that\'s the dream? And even if the home he remembers is real, how can Jason possibly make it back to the family he loves? The answers lie in a journey more wondrous and horrifying than anything he could\'ve imagined-one that will force him to confront the darkest parts of himself even as he battles a terrifying, seemingly unbeatable foe. Dark Matter is a brilliantly plotted tale that is at once sweeping and intimate, mind-bendingly strange and profoundly human-a relentlessly surprising science-fiction thriller about choices, paths not taken, and how far we\'ll go to claim the lives we dream of. From the Hardcover edition.',
  'identifier': '9781101904237',
  'extension': 'epub',
  'filesize': '478322',
});

final firstBook = _BookMock({
  'id': '1',
  'md5': '7b2a4d53fde834e801c26a2bab7e0240',
  'title': 'Handbook of Clinical Drug Data',
  'author': 'Philip Anderson',
  'year': '2001',
  'edition': '10',
  'publisher': 'McGraw-Hill Medical',
  'language': 'English',
  'descr': null,
  'identifier': '0-07-136362-9',
  'extension': 'pdf',
  'filesize': '3627486',
});

class _BookMock {
  final Book object;
  final Map json;

  _BookMock(this.json) : object = Book.fromJson(json);

  int get id => object.id;

  @override
  String toString() => object.toString();
}
