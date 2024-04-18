// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:syncrosong/objectbox.g.dart';

class Database {
  late final Store store;

  Database._(this.store);

  static Future<Database> create() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: path.join(documentsDirectory.path, "SyncroSong.DataBase"));
    return Database._(store);
  }
}