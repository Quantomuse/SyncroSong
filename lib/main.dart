import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/data/api/api.dart';
import 'package:syncrosong/data/database/database.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/router/router.dart';

import 'data/database/songs/song_search_db.dart';
import 'pages/song_search/search_song_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
    statusBarBrightness: Brightness.light,
  ));

  Database database = await Database.create();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SearchSongBloc>(
          create: (BuildContext context) => SearchSongBloc(SongSearchRepository(
            SongSearchDatabase(database),
            SongSearchApi(),
          )),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouteTreeHolder().get(),
      ),
    ),
  );
}
