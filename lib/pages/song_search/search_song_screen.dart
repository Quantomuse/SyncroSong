// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/router/router.dart';
import 'package:syncrosong/utility/widgets/loader_widget.dart';

import 'search_song_bloc.dart';
import 'search_song_text_field.dart';

class SearchSongScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  SearchSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchSongBloc, SearchSongState>(
      listener: (context, state) {
        if (state.navigationDestinationRoute != null) {
          context.push(state.navigationDestinationRoute!);
        }
      },
      builder: (context, state) {
        Widget viewWidget;
        Widget? floatingButton;

        switch (state.state) {
          case SearchQueryState.loading:
            viewWidget = const LoaderWidget();

          case SearchQueryState.error:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
              doesHaveError: true,
            );

          case SearchQueryState.resetToInitial:
            textEditingController.text = "";
            continue initial;

          initial:
          case SearchQueryState.initial:
            viewWidget = _SearchSongWidget(
              textEditingController,
              _onSearchSubmitted,
            );
        }

        return Scaffold(
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
              const ActionButton(
                Icons.settings,
                AppRoute.settings,
                Alignment.topRight,
              ),
              const ActionButton(
                Icons.history,
                AppRoute.history,
                Alignment.topLeft,
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

class ActionButton extends StatelessWidget {
  final IconData _icon;
  final Alignment _alignment;
  final AppRoute _navigationDestination;

  const ActionButton(this._icon, this._navigationDestination, this._alignment, {super.key});

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
        onPressed: () {
          context.push(_navigationDestination.route);
        },
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
