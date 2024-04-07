import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/data/api/api.dart';
import 'package:syncrosong/data/database/database.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/pages/history/history_screen_bloc.dart';
import 'package:syncrosong/router/router.dart';

import 'data/database/songs/song_search_db.dart';
import 'pages/song_search/search_song_bloc.dart';
import 'utility/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
    statusBarBrightness: Brightness.light,
  ));

  LogManager.initialize();
  final Database database = await Database.create();
  final SongRepository songRepository = SongRepository(
    SongSearchDatabase(database),
    SongSearchApi(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SearchSongBloc>(create: (BuildContext context) => SearchSongBloc(songRepository)),
        BlocProvider<SongHistoryBloc>(create: (BuildContext context) => SongHistoryBloc(songRepository))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouteTreeHolder().get(),
      ),
    ),
  );
}
