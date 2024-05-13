import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncrosong/localization/localized_text.dart';
import 'package:syncrosong/localization/text_manager.dart';
import 'package:syncrosong/utility/widgets/Separator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utility/local_properties_provider.dart';
import '../../utility/widgets/appbar_provider.dart';

class SettingsScreen extends StatelessWidget with TextProvider, AppBarProvider, LocalPropertiesProvider {

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(getText(LocalizedText.settingsScreenTitle), context),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SimpleSettingsRow(
            getText(LocalizedText.settingsSupport),
            () => launchUrl(supportUrl),
          ),
          const Separator(),
          _SimpleSettingsRow(
            getText(LocalizedText.settingsSubscribe),
            () => launchUrl(signupUrl),
          ),
          // const Separator(),
          // // TODO: implement https://pub.dev/packages/in_app_review once you upload to play store
          // _SimpleSettingsRow(
          //   getText(LocalizedText.settingsRate),
          //   null,
          // ),
          const Separator(),
          const _VersionSettingsRow(),
        ],
      ),
    );
  }
}

class _SimpleSettingsRow extends StatelessWidget {
  final String _text;
  final void Function()? _onPressed;

  const _SimpleSettingsRow(this._text, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onPressed,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            _text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}

class _VersionSettingsRow extends StatefulWidget {
  const _VersionSettingsRow({super.key});

  @override
  State<_VersionSettingsRow> createState() => _VersionSettingsRowState();
}

class _VersionSettingsRowState extends State<_VersionSettingsRow> {
  String _versionNumber = "";

  @override
  void initState() {
    super.initState();
    _getCurrentVersion();
  }

  @override
  Widget build(BuildContext context) {
    return _versionNumber.isNotEmpty ? _SimpleSettingsRow(_versionNumber, null) : const SizedBox.shrink();
  }

  Future<void> _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _versionNumber = "v${packageInfo.version}";
    });
  }
}
