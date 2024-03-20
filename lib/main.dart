import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/api.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/router/router.dart';

import 'pages/song_search/search_song_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
    statusBarBrightness: Brightness.light,
  ));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SearchSongBloc>(
          create: (BuildContext context) => SearchSongBloc(Api()),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouteTreeHolder().get(),
      ),
    ),
  );
}
