import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syncrosong/data/api/song_api_model.dart';

class SongSearchApi {
  static const String _songRequestUrl = "https://api.song.link/v1-alpha.1/links?url=";

  SongSearchApi();

  Future<SongApiModel> searchSongUrl(String url) async {
    DateTime searchTime = DateTime.now();
    var rawResponse = await http.get(Uri.parse("$_songRequestUrl$url"));
    final Map<String, dynamic> decodedResponse = jsonDecode(utf8.decode(rawResponse.bodyBytes)) as Map<String, dynamic>;
    return SongApiModel.fromJson(decodedResponse, searchTime, url);
  }

  Future<bool> isUrlValid(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  }
}
