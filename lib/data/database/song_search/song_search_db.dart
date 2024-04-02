import 'package:syncrosong/data/database/database.dart';
import 'package:syncrosong/data/database/song_search/song_db_model.dart';
import 'package:syncrosong/objectbox.g.dart';

class SongSearchDatabase {
  final Database _database;
  late Box<SongDBModel> _store;

  SongSearchDatabase(this._database) {
    _store = _database.store.box<SongDBModel>();
  }

  Future<List<SongDBModel>> getHistory() async => _store.getAllAsync();

  Future<void> saveSong(SongDBModel songSearchDBModel) async {
    await _store.putAsync(songSearchDBModel, mode: PutMode.put);
  }

  Future<List<SongDBModel>> findSavedSong(String searchUrl) async {
    Query<SongDBModel> query = _store.query(SongDBModel_.searchUrl.equals(searchUrl)).build();
    List<SongDBModel> dbModels = await query.findAsync();
    return dbModels;
  }
}