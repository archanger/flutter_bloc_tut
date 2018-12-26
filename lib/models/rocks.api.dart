import 'dart:convert';

import 'package:bloc_learning/models/model.dart';
import 'package:http/http.dart' show Client;

class RocksApi {
  final _client = Client();

  static const _url = 'https://utopian.rocks/api/posts?status={0}';

  Future<List<Contribution>> getContributions({
    String pageName = 'unreviewed',
  }) async {
    List<Contribution> items = [];

    await _client
        .get(Uri.parse(_url.replaceFirst('{0}', pageName)))
        .then((result) => result.body)
        .then(json.decode)
        .then((json) => json.forEach((contribution) {
              final con = Contribution.fromJson(contribution);
              if (con.status == pageName) {
                items.add(con);
              }
            }));

    return items;
  }
}
