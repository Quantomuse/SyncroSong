import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:syncrosong/data/api/song_api_model.dart';

import '../../utility/local_properties_provider.dart';

class SongSearchApi with LocalPropertiesProvider {

  Future<SongApiModel> searchSongUrl(String url) async {
    DateTime searchTime = DateTime.now();
    var rawResponse = await http.get(Uri.parse("$apiBaseUrl$songSearchApiPostfix$url"));
    final Map<String, dynamic> decodedResponse = jsonDecode(utf8.decode(rawResponse.bodyBytes)) as Map<String, dynamic>;
    return SongApiModel.fromJson(decodedResponse, searchTime, url);
  }

  Future<bool> isUrlValid(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response.statusCode == 200;
  }
}
