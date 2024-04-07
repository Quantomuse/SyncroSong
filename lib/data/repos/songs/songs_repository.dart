import 'package:syncrosong/data/api/api.dart';
import 'package:syncrosong/data/api/song_api_model.dart';
import 'package:syncrosong/data/repos/songs/song_item.dart';

import '../../database/songs/song_db_model.dart';
import '../../database/songs/song_search_db.dart';

class SongRepository with SongItemConverter {
  final SongSearchDatabase songSearchDatabase;
  final SongSearchApi _api;

  SongRepository(this.songSearchDatabase, this._api);

  Future<List<SongItem>> getHistory() async => fromDBModels(await songSearchDatabase.getHistory());

  Future<SongItem> search(String searchUrl) async {
    //
    // Are there cached songs?
    List<SongItemDBModel> savedSearches = await songSearchDatabase.findSavedSong(searchUrl);
    List<SongItem> songItems = fromDBModels(savedSearches);
    for (SongItem songItem in songItems) {
      //
      // Is the saved song's url still valid?
      if (await _api.isUrlValid(songItem.displayUrl)) {
        SongItem newSongItemSearchData = fromSongItemWithNewDate(songItem, DateTime.now());
        //
        // Save record for a new search
        await songSearchDatabase.saveSong(fromSongItem(newSongItemSearchData));
        return newSongItemSearchData;
      }
    }

    //
    // No songs in cache -> request song from the api
    SongApiModel songApiModel = await _api.searchSongUrl(searchUrl);

    SongItem songItem = fromApiModel(songApiModel);

    //
    // Save record for a new search
    await songSearchDatabase.saveSong(fromSongItem(songItem));

    return songItem;
  }
}
