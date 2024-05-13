import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/localization/text_manager.dart';
import 'package:syncrosong/styling_guide.dart';
import 'package:syncrosong/utility/widgets/loader_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/widgets/floating_share_button.dart';

class FullMusicLinksScreen extends StatefulWidget {
  final WebViewController webViewController = WebViewController();
  final String url;

  FullMusicLinksScreen(String? url, {super.key}) : url = url ?? "";

  @override
  State<FullMusicLinksScreen> createState() => _FullMusicLinksScreenState();
}

class _FullMusicLinksScreenState extends State<FullMusicLinksScreen> with TextProvider {
  bool _isLoading = true;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();

    Uri uri = Uri.parse(widget.url);
    uri.replace(scheme: "https");
    widget.webViewController.loadRequest(uri);

    widget.webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    widget.webViewController.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (_) => _onPageFinishedLoading(),
      onNavigationRequest: _onNavigationRequest,
      onProgress: _onProgress,
    ));
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: _isLoading
          ? Container(
              decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
              constraints: const BoxConstraints.expand(width: double.infinity, height: double.infinity),
              child: const LoaderWidget())
          : Stack(children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: MediaQuery.of(context).viewPadding.top),
                      Flexible(
                        child: WebViewWidget(controller: widget.webViewController),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor, //Color(0x80079B4C)
                  ),
                  child: IconButton(
                      onPressed: () => context.pop(),
                      color: theme.scaffoldBackgroundColor,
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                      )),
                ),
              ),
            ]),
      floatingActionButton: _isLoading ? null : FloatingShareButton(widget.url),
    );
  }

  void _onPageFinishedLoading() {
    final String backgroundColor = theme.scaffoldBackgroundColor.toHex();
    final String lightBackgroundColor = theme.colorScheme.background.toHex();
    //
    // Deliberately hiding the bottom customization & attribution divs +
    // theming it to use dark or light theme in conjunction with the app.
    widget.webViewController.runJavaScript("""
        javascript:(function() {
          document.body.style.background='$backgroundColor'
          document.getElementsByClassName('css-12bjhyh')[0].style.background='$lightBackgroundColor';
          document.getElementsByClassName('css-1v5k611')[0].style.background='$lightBackgroundColor';
          document.getElementsByClassName('css-12bjhyh')[1].style.background='$lightBackgroundColor';
          document.getElementsByClassName('css-12bjhyh')[2].style.background='$lightBackgroundColor';
          document.getElementsByClassName('css-1lcypyy')[0].style.display='none';
          document.getElementsByClassName('css-d8rran')[0].style.display='none';
        })()""");
    setState(() {
      _isLoading = false;
    });
  }

  void _onProgress(int progressPercent) {
    // Left for options
  }

  NavigationDecision _onNavigationRequest(NavigationRequest navigationRequest) {
    if (navigationRequest.url.contains("song.link")) {
      return NavigationDecision.navigate;
    } else {
      launchUrl(Uri.parse(navigationRequest.url));
      return NavigationDecision.prevent;
    }
  }
}
