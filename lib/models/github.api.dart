import 'dart:convert';

import 'package:bloc_learning/models/model.dart';
import 'package:http/http.dart' show Client;

class GithubApi {
  final Client _client = Client();
  static const _url = 'https://api.github.com/repos/archanger/flutter_bloc_tut/releases';

  Future<GithubModel> getReleases() async {
    final resBody = await _client
        .get(Uri.parse(_url))
        .then((response) => response.body)
        .then(json.decode)
        .then((r) => r as List)
        .then((result) => result.map((g) => GithubModel.fromJson(g)).first);

    return resBody;
  }
}
