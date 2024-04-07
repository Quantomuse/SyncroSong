import 'dart:convert';

import 'package:syncrosong/data/api/song_api_model.dart';

import '../../database/songs/song_db_model.dart';

class SongItem {
  final DateTime searchTime;
  final String searchUrl;
  final String displayUrl;
  final String title;
  final String artist;
  final Map<SongPlatformType, String> musicPlatformUrls;

  SongItem._({
    required this.searchTime,
    required this.searchUrl,
    required this.displayUrl,
    required this.title,
    required this.artist,
    required this.musicPlatformUrls,
  });

  @override
  String toString() {
    return 'SongItem{searchTime: $searchTime, searchUrl: $searchUrl, displayUrl: $displayUrl, title: $title, artist: $artist, musicPlatformUrls: $musicPlatformUrls}';
  }
}

enum SongPlatformType {
  amazonMusic,
  amazonStore,
  audiomack,
  anghami,
  boomplay,
  deezer,
  appleMusic,
  itunes,
  napster,
  pandora,
  soundcloud,
  tidal,
  yandex,
  youtube,
  youtubeMusic,
  spotify;

  static SongPlatformType? getByName(String enumName) {
    for (SongPlatformType enumType in SongPlatformType.values) {
      if (enumName == enumType.name) {
        return enumType;
      }
    }
    return null;
  }
}

mixin SongItemConverter {
  SongItem? fromDBModel(SongItemDBModel songDBModel) => songDBModel.hasNoMissingValues()
      ? SongItem._(
          searchTime: songDBModel.searchTime!,
          searchUrl: songDBModel.searchUrl!,
          displayUrl: songDBModel.displayUrl!,
          title: songDBModel.title!,
          artist: songDBModel.artist!,
          musicPlatformUrls: _convertStringJsonToPlatformTypeMap(songDBModel.musicPlatformUrlsJson!),
        )
      : null;

  SongItem fromSongItemWithNewDate(SongItem songItem, DateTime searchTime) => SongItem._(
      searchTime: searchTime,
      searchUrl: songItem.searchUrl,
      displayUrl: songItem.displayUrl,
      title: songItem.title,
      artist: songItem.artist,
      musicPlatformUrls: songItem.musicPlatformUrls);

  SongItemDBModel fromSongItem(SongItem songItem) => SongItemDBModel(
        songItem.searchTime,
        songItem.searchUrl,
        songItem.displayUrl,
        songItem.title,
        songItem.artist,
        _convertPlatformTypeMapToStringJson(songItem.musicPlatformUrls),
      );

  SongItem fromApiModel(SongApiModel songApiModel) => SongItem._(
        searchTime: songApiModel.searchTime,
        searchUrl: songApiModel.searchUrl,
        displayUrl: songApiModel.displayUrl,
        title: songApiModel.title,
        artist: songApiModel.artist,
        musicPlatformUrls: _convertStringMapToPlatformTypeMap(songApiModel.musicPlatformUrls),
      );

  List<SongItem> fromDBModels(List<SongItemDBModel> dbModels) {
    List<SongItem> convertedModels = [];
    for (SongItemDBModel dbModel in dbModels) {
      SongItem? songItem = fromDBModel(dbModel);
      if (songItem != null) {
        convertedModels.add(songItem);
      }
    }
    return convertedModels;
  }

  Map<SongPlatformType, String> _convertStringJsonToPlatformTypeMap(String songPlatformLinksJson) {
    Map<String, dynamic> map = jsonDecode(songPlatformLinksJson);
    Map<SongPlatformType, String> songPlatformToLinkMap = {};
    for (MapEntry<String, dynamic> musicPlatformMapEntry in map.entries) {
      SongPlatformType? songPlatformType = SongPlatformType.getByName(musicPlatformMapEntry.key);
      if (songPlatformType != null) {
        songPlatformToLinkMap[songPlatformType] = musicPlatformMapEntry.value;
      }
    }
    return songPlatformToLinkMap;
  }

  String _convertPlatformTypeMapToStringJson(Map<SongPlatformType, String> map) {
    Map<String, String> stringMap = map.map((key, value) => MapEntry(key.name, value));
    return jsonEncode(stringMap);
  }

  Map<SongPlatformType, String> _convertStringMapToPlatformTypeMap(Map<String, String> map) {
    Map<SongPlatformType, String> songPlatformToLinkMap = {};
    for (MapEntry<String, String> musicPlatformMapEntry in map.entries) {
      SongPlatformType? songPlatformType = SongPlatformType.getByName(musicPlatformMapEntry.key);
      if (songPlatformType != null) {
        songPlatformToLinkMap[songPlatformType] = musicPlatformMapEntry.value;
      }
    }
    return songPlatformToLinkMap;
  }
}
