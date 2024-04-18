import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/data/repos/songs/songs_repository.dart';
import 'package:syncrosong/pages/full_music_links/full_music_links_screen.dart';
import 'package:syncrosong/pages/history/history_screen.dart';
import 'package:syncrosong/pages/settings/settings_screen.dart';

import '../pages/history/history_screen_bloc.dart';
import '../pages/song_search/search_song_screen.dart';

enum AppRoute {
  searchSong,
  settings,
  history,
  fullMusicLinks;

  String get route => "/$name";
}

class AppRouteTreeHolder {
  late GoRouter _router;

  AppRouteTreeHolder(SongRepository songRepository) {
    _router = GoRouter(
      initialLocation: AppRoute.searchSong.route,
      routes: [
        _DefaultGoRoute(
          path: AppRoute.searchSong.route,
          builder: (context, state) => SearchSongScreen(),
        ),
        _DefaultGoRoute(
          path: AppRoute.settings.route,
          builder: (context, state) => const SettingsScreen(),
        ),
        _DefaultGoRoute(
          path: AppRoute.history.route,
          builder: (context, state) => BlocProvider<SongHistoryBloc>(
            create: (BuildContext context) => SongHistoryBloc(songRepository),
            child: const HistoryScreen(),
          ),
        ),
        _DefaultGoRoute(
          path: AppRoute.fullMusicLinks.route,
          builder: (context, state) {
            return FullMusicLinksScreen(state.uri.queryParameters[AppNavigationParameterKeys.url]);
          },
        ),
      ],
    );
  }

  GoRouter get() => _router;
}

class _DefaultGoRoute extends GoRoute {
  _DefaultGoRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
  }) : super(
            path: path,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
                  child: builder(context, state),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                    opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                    child: child,
                  ),
                ));
}

class AppNavigationParameterKeys {
  static const String url = "url";
}
