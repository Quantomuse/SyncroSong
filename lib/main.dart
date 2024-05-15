import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syncrosong/di/dependency_locator.dart';
import 'package:syncrosong/router/router.dart';
import 'package:syncrosong/styling_guide.dart';

import 'utility/logger.dart';

void main() async {
  await dotenv.load(fileName: "local_properties.env");

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.statusBarColor,
  ));

  LogManager.initialize();

  DependencyHandler dependencyHandler = DependencyHandler();
  await dependencyHandler.setupDependencies();

  runApp(
    Builder(
      builder: (BuildContext buildContext) {
        bool isDarkMode = buildContext.isDarkMode;
        return MaterialApp.router(
          theme: isDarkMode ? AppThemeProvider.createDarkTheme() : AppThemeProvider.createLightTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouteTreeHolder(dependencyHandler).get(),
        );
      },
    ),
  );
}
