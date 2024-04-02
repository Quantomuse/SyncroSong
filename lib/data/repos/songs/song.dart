import 'package:syncrosong/data/api/song_api_model.dart';

import '../../database/songs/song_db_model.dart';

class SongItem {
  final DateTime searchTime;
  final String searchUrl;
  final String displayUrl;
  final String name;

  SongItem._(this.searchTime, this.searchUrl, this.displayUrl, this.name);
}

mixin SongConverter {
  SongItem? fromDBModel(SongDBModel songDBModel) => songDBModel.hasNoMissingValues()
      ? SongItem._(
          songDBModel.searchTime!,
          songDBModel.searchUrl!,
          songDBModel.displayUrl!,
          songDBModel.name!,
        )
      : null;

  SongItem fromSongItemWithNewDate(SongItem songItem, DateTime searchTime) => SongItem._(
        searchTime,
        songItem.searchUrl,
        songItem.displayUrl,
        songItem.name,
      );

  SongDBModel fromSongItem(SongItem songItem) => SongDBModel(
        songItem.searchTime,
        songItem.searchUrl,
        songItem.displayUrl,
        songItem.name,
      );

  SongItem fromApiModel(SongApiModel songApiModel) => SongItem._(
        songApiModel.searchTime,
        songApiModel.searchUrl,
        songApiModel.displayUrl,
        songApiModel.name,
      );

  List<SongItem> fromDBModels(List<SongDBModel> dbModels) {
    List<SongItem> convertedModels = [];
    for (SongDBModel dbModel in dbModels) {
      SongItem? songItem = fromDBModel(dbModel);
      if (songItem != null) {
        convertedModels.add(songItem);
      }
    }
    return convertedModels;
  }
}
