import 'package:get_it/get_it.dart';
import 'package:syncrosong/data/api/api.dart';
import 'package:syncrosong/data/database/database.dart';
import 'package:syncrosong/data/database/songs/song_search_db.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/pages/history/history_screen_bloc.dart';
import 'package:syncrosong/pages/song_search/search_song_bloc.dart';

class DependencyHandler {
  late GetIt locator;

  Future<void> setupDependencies() async {
    locator = GetIt.instance;

    locator.registerSingleton<Database>(await Database.create());
    locator.registerSingleton<SongSearchDatabase>(SongSearchDatabase(get()));
    locator.registerSingleton<SongSearchApi>(SongSearchApi());
    locator.registerSingleton(SongRepository(
      get(),
      get(),
    ));

    locator.registerFactory<SearchSongBloc>(() => SearchSongBloc(get()));
    locator.registerFactory<SongHistoryBloc>(() => SongHistoryBloc(get()));
  }

  T get<T extends Object>() => locator.get<T>();
}
