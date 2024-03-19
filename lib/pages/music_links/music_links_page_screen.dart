import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/pages/music_links/music_links_page_bloc.dart';
import 'package:syncrosong/pages/music_links/widgets/music_links_webview.dart';
import 'package:syncrosong/pages/music_links/widgets/search_song_text_field.dart';
import 'package:syncrosong/router/router.dart';
import 'package:syncrosong/utility/widgets/floating_share_button.dart';
import 'package:syncrosong/utility/widgets/loader_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MusicPlatformsPageScreen extends StatelessWidget {
  final WebViewController webViewController = WebViewController();
  final TextEditingController textEditingController = TextEditingController();

  MusicPlatformsPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicPlatformsPageBloc, MusicPlatformsPageState>(
      listener: (BuildContext context, MusicPlatformsPageState state) {
        if (state.state == WebPageState.ready && state.pageUrl != null) {
          Uri uri = Uri.parse(state.pageUrl ?? "");
          uri.replace(scheme: "https");
          webViewController.loadRequest(uri);
        }
      },
      builder: (context, state) {
        Widget viewWidget;
        Widget? floatingButton;

        switch (state.state) {
          case WebPageState.loading:
            viewWidget = const LoaderWidget();

          case WebPageState.error:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
              doesHaveError: true,
            );

          case WebPageState.ready:
            if (state.pageUrl != null) {
              floatingButton = FloatingShareButton(state.pageUrl!);
              viewWidget = MusicLinksWebView(webViewController);
            } else {
              viewWidget = _SearchSongWidget(
                textEditingController,
                _onSearchSubmitted,
                doesHaveError: true,
              );
            }

          case WebPageState.initial:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
            );
        }

        return PopScope(
          canPop: state.state == WebPageState.initial,
          onPopInvoked: (didPop) {
            if (state.state != WebPageState.initial) {
              BlocProvider.of<MusicPlatformsPageBloc>(context).add(BackNavigationEvent());
            } else {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            primary: false,
            floatingActionButton: floatingButton,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                    ),
                    onPressed: () {},
                    icon: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).viewPadding.top + 16,
                          right: 16,
                          left: 16,
                          bottom: 16,
                        ),
                        child: const Icon(Icons.settings)),
                    color: AppColors.mainColor,
                  ),
                ),
                ActionButton(
                  Icons.settings,
                  () {
                    context.go(AppScreens.settings);
                  },
                  Alignment.topRight,
                ),
                ActionButton(
                  Icons.history,
                  () {
                    context.go(AppScreens.history);
                  },
                  Alignment.topLeft,
                ),
                viewWidget,
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSearchSubmitted(BuildContext context) {
    BlocProvider.of<MusicPlatformsPageBloc>(context).add(ShareLinkUrl(textEditingController.text));
    textEditingController.text = "";
  }
}

class _SearchSongWidget extends StatefulWidget {
  final TextEditingController _textEditingController;
  final Function(BuildContext context) _onSearchPressed;
  final bool? doesHaveError;

  const _SearchSongWidget(
    this._textEditingController,
    this._onSearchPressed, {
    super.key,
    this.doesHaveError,
  });

  @override
  State<_SearchSongWidget> createState() => _SearchSongWidgetState();
}

class _SearchSongWidgetState extends State<_SearchSongWidget> {
  bool? _doesHaveError;

  @override
  void initState() {
    super.initState();
    _doesHaveError = widget.doesHaveError;
    if (_doesHaveError == true) {
      widget._textEditingController.addListener(_observeTextFieldChanges);
    }
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: SearchSongTextField(
                  widget._textEditingController,
                  widget._onSearchPressed,
                  doesHaveError: _doesHaveError,
                ),
              )
            ],
          ),
        ),
      );

  void _observeTextFieldChanges() {
    if (_doesHaveError == true) {
      setState(() {
        _doesHaveError = false;
        widget._textEditingController.removeListener(_observeTextFieldChanges);
      });
    }
  }
}

class ActionButton extends StatelessWidget {
  final IconData _icon;
  final Alignment _alignment;
  final void Function() _onPressed;

  const ActionButton(this._icon, this._onPressed, this._alignment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignment,
      child: IconButton(
        iconSize: 25,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
        ),
        onPressed: _onPressed,
        icon: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 16,
              right: 16,
              left: 16,
              bottom: 16,
            ),
            child: Icon(_icon)),
        color: AppColors.mainColor,
      ),
    );
  }
}
