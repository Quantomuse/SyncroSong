import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:syncrosong/data/api/song_api_model.dart';

class SongSearchApi {
  late String _apiBaseUrl;
  late String _songSearchApiPostfix;

  SongSearchApi() {
    String? apiBaseUrl = dotenv.env['api_url'];
    String? songSearchApiPostfix = dotenv.env['song_search_postfix'];
    if (apiBaseUrl != null && songSearchApiPostfix != null) {
      _apiBaseUrl = apiBaseUrl;
      _songSearchApiPostfix = songSearchApiPostfix;
    } else {
      throw Exception("Missing api ulr! Please provide an API URL for the functionality of the app to work :)");
    }
  }

  Future<SongApiModel> searchSongUrl(String url) async {
    DateTime searchTime = DateTime.now();
    var rawResponse = await http.get(Uri.parse("$_apiBaseUrl$_songSearchApiPostfix$url"));
    final Map<String, dynamic> decodedResponse = jsonDecode(utf8.decode(rawResponse.bodyBytes)) as Map<String, dynamic>;
    return SongApiModel.fromJson(decodedResponse, searchTime, url);
  }

  Future<bool> isUrlValid(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  }
}
