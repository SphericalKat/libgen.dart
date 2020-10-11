import 'package:http/http.dart' as http;

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
