import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syncrosong/data/api/song_api_model.dart';

class SongSearchApi {
  static const String _songRequestUrl = "https://api.song.link/v1-alpha.1/links?url=";

  SongSearchApi();

  Future<SongApiModel> searchSongUrl(String url) async {
    DateTime searchTime = DateTime.now();
    var response = await http.get(Uri.parse("$_songRequestUrl$url"));
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // requestPageUrlForX(decodedResponse["pageUrl"]);
    String displayUrl = decodedResponse["pageUrl"];
    return SongApiModel(searchTime, url, displayUrl, "TBD");
  }

  Future<bool> isUrlValid(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  }
}