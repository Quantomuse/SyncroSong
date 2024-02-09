import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncrosong/colors.dart';
import 'package:syncrosong/localization/text_keys.dart';
import 'package:syncrosong/localization/text_manager.dart';
import 'package:syncrosong/utility/widgets/clipboard_paste_button.dart';

class SearchSongTextField extends StatelessWidget with TextProvider {
  final TextEditingController textEditingController;
  final Function(BuildContext context) _onSearchPressed;
  final bool? doesHaveError;

  const SearchSongTextField(
    this.textEditingController,
    this._onSearchPressed, {
    super.key,
    this.doesHaveError,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.mainColor, width: 2),
    );
    final OutlineInputBorder errorBorderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
    );
    TextStyle textStyle = const TextStyle(
      color: AppColors.mainColor,
      fontWeight: FontWeight.bold,
    );
    TextStyle errorTextStyle = const TextStyle(
      color: AppColors.errorColor,
      fontWeight: FontWeight.bold,
    );
    return Stack(
      alignment: Alignment.topRight,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: getText(LocalizedText.songSearchHintKey),
            enabledBorder: borderDecoration,
            border: borderDecoration,
            focusedBorder: borderDecoration,
            errorBorder: errorBorderDecoration,
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 100,
              top: 8,
              bottom: 8,
            ),
            hintStyle: textStyle,
            errorText: doesHaveError == true ? getText(LocalizedText.songSharedUrlInvalidError) : null,
            errorStyle: errorTextStyle
          ),
          controller: textEditingController,
          focusNode: FocusNode(),
          maxLines: 8,
          minLines: 1,
          style: textStyle,
          cursorColor: AppColors.mainColor,
          enableInteractiveSelection: true,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipboardPastButton(
              (text) => _onClipboardDataPasted(context, text),
              _onNoClipboardDataFound,
            ),
            IconButton(
              iconSize: 25,
              onPressed: () => _onSearchPressed(context),
              color: AppColors.mainColor,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.search),
            )
          ],
        )
      ],
    );
  }

  void _onClipboardDataPasted(BuildContext context, String text) {
    textEditingController.text = text;
    _onSearchPressed(context);
  }

  void _onNoClipboardDataFound() {
    Fluttertoast.showToast(msg: getText(LocalizedText.songSearchClipboardNoUrlFound));
  }
}
