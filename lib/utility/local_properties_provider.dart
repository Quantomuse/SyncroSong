import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin LocalPropertiesProvider {

  final String apiBaseUrl = _getLocalProperty('api_url');

  final String songSearchApiPostfix = _getLocalProperty('song_search_postfix');

  final Uri supportUrl = Uri.parse(_getLocalProperty('support_url'));

  final Uri signupUrl = Uri.parse(_getLocalProperty('email_list_url'));

  static String _getLocalProperty(String key) {
    String? value = dotenv.env[key];
    if (value != null) {
      return value;
    } else {
      throw Exception("Missing value for $key! Please provide a value for the requested key in your .env file");
    }
  }
}