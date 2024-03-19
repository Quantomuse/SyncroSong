import 'package:go_router/go_router.dart';
import 'package:syncrosong/pages/history/history_screen.dart';
import 'package:syncrosong/pages/music_links/music_links_page_screen.dart';
import 'package:syncrosong/pages/settings/settings_screen.dart';

class AppScreens {
  static const String settings = "settings";
  static const String history = "history";
}

class AppRouter {
  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => MusicPlatformsPageScreen(), routes: [
        GoRoute(
          path: AppScreens.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: AppScreens.history,
          builder: (context, state) => const HistoryScreen(),
        ),
      ]),
    ],
  );

  GoRouter get() => _router;
}
