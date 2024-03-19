import 'package:flutter/material.dart';
import 'package:syncrosong/utility/widgets/loader_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MusicLinksWebView extends StatefulWidget {
  final WebViewController webViewController;

  const MusicLinksWebView(this.webViewController, {super.key});

  @override
  State<MusicLinksWebView> createState() => _MusicLinksWebViewState();
}

class _MusicLinksWebViewState extends State<MusicLinksWebView> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    widget.webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    widget.webViewController.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (_) => _onPageFinishedLoading(),
      onNavigationRequest: _onNavigationRequest,
      onProgress: _onProgress,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          decoration: const BoxDecoration(color: Colors.white),
          constraints: const BoxConstraints.expand(width: double.infinity, height: double.infinity),
          child: const LoaderWidget());
    } else {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery
              .of(context)
              .size
              .height),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: MediaQuery
                .of(context)
                .viewPadding
                .top),
            Flexible(
              child: WebViewWidget(controller: widget.webViewController),
            ),
          ]),
        ),
      );
    }
  }

  void _onPageFinishedLoading() {
    // Deliberately hiding the bottom customization & attribution divs
    widget.webViewController.runJavaScript("""
        javascript:(function() {
          document.getElementsByClassName('css-1lcypyy')[0].style.display='none';
          document.getElementsByClassName('css-d8rran')[0].style.display='none';
        })()""");
    setState(() {
      isLoading = false;
    });
  }

  void _onProgress(int progressPercent) {
    // TODO: Add a loader to the add view here
    print("Loading web page: $progressPercent");
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
