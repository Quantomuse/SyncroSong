import 'package:syncrosong/data/database/database.dart';
import 'package:syncrosong/objectbox.g.dart';

import 'song_db_model.dart';

class SongSearchDatabase {
  final Database _database;
  late Box<SongItemDBModel> _store;

  SongSearchDatabase(this._database) {
    _store = _database.store.box<SongItemDBModel>();
  }

  Future<List<SongItemDBModel>> getHistory() async {
    Query<SongItemDBModel> query = _store.query().order(SongItemDBModel_.searchTime, flags: Order.descending).build();
    return query.findAsync();
  }

  Future<void> saveSong(SongItemDBModel songSearchDBModel) async {
    await _store.putAsync(songSearchDBModel, mode: PutMode.put);
  }

  Future<List<SongItemDBModel>> findSavedSong(String searchUrl) async {
    Query<SongItemDBModel> query = _store.query(SongItemDBModel_.searchUrl.equals(searchUrl)).build();
    List<SongItemDBModel> dbModels = await query.findAsync();
    return dbModels;
  }
}
