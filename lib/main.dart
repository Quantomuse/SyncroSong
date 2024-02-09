import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncrosong/api.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/music_links/music_links_page_bloc.dart';
import 'package:syncrosong/music_links/music_links_page_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainColor,
    statusBarBrightness: Brightness.light,
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MusicPlatformsPageBloc>(
        create: (BuildContext context) => MusicPlatformsPageBloc(Api()),
      )
    ],
    child: MaterialApp(
      home: MusicPlatformsPageScreen(),
      //debugShowCheckedModeBanner: false,
    ),
  ));
}
