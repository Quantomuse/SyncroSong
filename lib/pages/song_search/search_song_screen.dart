// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/router/router.dart';
import 'package:syncrosong/utility/widgets/loader_widget.dart';

import 'search_song_bloc.dart';
import 'search_song_text_field.dart';

class SearchSongScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  SearchSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return BlocConsumer<SearchSongBloc, SearchSongState>(
      listener: (context, state) async {
        if (state.navigationDestinationRoute != null) {
          await context.push(state.navigationDestinationRoute!);

          // ignore: use_build_context_synchronously
          BlocProvider.of<SearchSongBloc>(context).add(ReturnedFromResultScreenEvent());
        }
      },
      builder: (context, state) {
        Widget viewWidget;

        switch (state.state) {
          case SearchQueryState.resetToInitial:
            textEditingController.text = "";
            continue loading;

          loading:
          case SearchQueryState.loading:
            viewWidget = const LoaderWidget();

          case SearchQueryState.error:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
              doesHaveError: true,
            );

          case SearchQueryState.initial:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
            );
        }

        return Scaffold(
          backgroundColor: themeData.scaffoldBackgroundColor,
          primary: false,
          body: Stack(
            children: [
              _ActionButton(
                Icons.settings,
                AppRoute.settings,
                Alignment.topRight,
                state.state,
              ),
              _ActionButton(
                Icons.history,
                AppRoute.history,
                Alignment.topLeft,
                state.state,
                onScreenResult: (songSelected) =>
                    BlocProvider.of<SearchSongBloc>(context).add(SongSubmitEvent(songSelected)),
              ),
              viewWidget,
            ],
          ),
        );
      },
    );
  }

  void _onSearchSubmitted(BuildContext context) {
    BlocProvider.of<SearchSongBloc>(context).add(SongSubmitEvent(textEditingController.text));
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

class _ActionButton extends StatelessWidget {
  final IconData _icon;
  final Alignment _alignment;
  final AppRoute _navigationDestination;
  final SearchQueryState _state;
  final void Function(String)? onScreenResult;
  final List<SearchQueryState> _listOfStatesToHideButton = [SearchQueryState.loading, SearchQueryState.resetToInitial];

  _ActionButton(
    this._icon,
    this._navigationDestination,
    this._alignment,
    this._state, {
    this.onScreenResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return _listOfStatesToHideButton.contains(_state)
        ? const SizedBox.shrink()
        : Align(
            alignment: _alignment,
            child: IconButton(
              iconSize: 25,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
              ),
              onPressed: () async {
                if (onScreenResult != null) {
                  String? urlResponse = await context.push(_navigationDestination.route) as String?;
                  if (urlResponse != null) {
                    onScreenResult!(urlResponse);
                  }
                } else {
                  context.push(_navigationDestination.route);
                }
              },
              icon: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 16,
                    right: 16,
                    left: 16,
                    bottom: 16,
                  ),
                  child: Icon(_icon)),
              color: themeData.primaryColor,
            ),
          );
  }
}
