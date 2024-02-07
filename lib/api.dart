import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const String _songRequestUrl = "https://api.song.link/v1-alpha.1/links?url=";

  Api();

  Future<String> requestPageUrlFor(String url) async {
    var response = await http.get(Uri.parse("$_songRequestUrl$url"));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // requestPageUrlForX(decodedResponse["pageUrl"]);
    return decodedResponse["pageUrl"];
  }
}