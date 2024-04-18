import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardPasteButton extends StatefulWidget {
  final void Function(String clipboardText) onClipboardTextFound;
  final void Function() onNoClipboardTextFound;

  const ClipboardPasteButton(this.onClipboardTextFound, this.onNoClipboardTextFound, {super.key});

  @override
  State<ClipboardPasteButton> createState() => _ClipboardPasteButtonState();
}

class _ClipboardPasteButtonState extends State<ClipboardPasteButton> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    if (!_isLoading) {
      return _getButtonView(themeData);
    } else {
      return const SizedBox();
    }
  }

  Widget _getButtonView(ThemeData themeData) => IconButton(
        iconSize: 25,
        padding: EdgeInsets.zero,
        onPressed: _pasteFromClipboard,
        icon: const Icon(Icons.paste),
        color: themeData.primaryColor,
      );

  void _pasteFromClipboard() async {
    setState(() {
      _isLoading = true;
    });
    final ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      widget.onClipboardTextFound(clipboardData.text!);
    } else {
      widget.onNoClipboardTextFound();
    }
    setState(() {
      _isLoading = false;
    });
  }
}
