import 'package:syncrosong/data/api/api.dart';
import 'package:syncrosong/data/api/song_api_model.dart';
import 'package:syncrosong/data/database/song_search/song_search_db.dart';
import 'package:syncrosong/data/database/song_search/song_db_model.dart';
import 'package:syncrosong/data/repos/song.dart';

class SongSearchRepository with SongConverter {
  final SongSearchDatabase songSearchDatabase;
  final SongSearchApi _api;

  SongSearchRepository(this.songSearchDatabase, this._api);

  Future<List<SongItem>> getHistory() async => fromDBModels(await songSearchDatabase.getHistory());

  Future<SongItem> search(String searchUrl) async {
    List<SongDBModel> savedSearches = await songSearchDatabase.findSavedSong(searchUrl);
    List<SongItem> songItems = fromDBModels(savedSearches);
    for (SongItem songItem in songItems) {
      if (await _api.isUrlValid(songItem.displayUrl)) {
        SongItem newSongItemSearchData = fromSongItemWithNewDate(songItem, DateTime.now());
        await songSearchDatabase.saveSong(fromSongItem(newSongItemSearchData));
        return newSongItemSearchData;
      }
    }

    SongApiModel songApiModel = await _api.searchSongUrl(searchUrl);
    SongItem songItem = fromApiModel(songApiModel);

    await songSearchDatabase.saveSong(fromSongItem(songItem));

    return songItem;
  }
}