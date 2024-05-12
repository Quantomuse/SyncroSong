import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncrosong/localization/localized_text.dart';
import 'package:syncrosong/localization/text_manager.dart';

class FloatingShareButton extends StatelessWidget with TextProvider {
  final String _shareUrl;

  const FloatingShareButton(this._shareUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      backgroundColor: themeData.primaryColor,
      onPressed: () {
        Share.share(getText(LocalizedText.songShareText, value: _shareUrl));
      },
      child: Icon(
        Platform.isAndroid ? Icons.share : Icons.ios_share,
        color: Colors.white,
      ),
    );
  }
}
