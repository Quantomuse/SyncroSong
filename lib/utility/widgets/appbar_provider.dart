import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../styling_guide.dart';

class AppBarProvider {
  static AppBar get(String text, BuildContext buildContext) {
    ThemeData theme = Theme.of(buildContext);
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.statusBarColor,
      ),
      foregroundColor: theme.appBarTheme.foregroundColor,
      centerTitle: true,
      title: Text(
        text,
        style: theme.appBarTheme.titleTextStyle,
      ),
      backgroundColor: theme.appBarTheme.backgroundColor,
    );
  }
}
