import 'package:http/http.dart' as http;
import 'package:libgen/src/page_parser.dart';

Future<String> getSearchPage() => http
    .get('http://libgen.rs/search.php?req=something')
    .then((res) => res.body);

String getHtmlPageWithIds(List<int> ids) => '''
  <html>
    <body>
    <table class="c">
      <tr><td>ID</td></tr>
      ${ids.map((id) => '<tr><td>${id}</td></tr>')}
    </table>
    </body>
  </html>
  ''';

PageParser getParsedHtmlPageWithIds(List<int> ids) =>
    PageParser(getHtmlPageWithIds(ids));
