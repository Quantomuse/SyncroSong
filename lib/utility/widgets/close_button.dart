import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor,
      ),
      child: IconButton(
          onPressed: () => context.pop(),
          color: theme.scaffoldBackgroundColor,
          icon: const Icon(
            Icons.close,
            size: 25,
          )),
    );
  }
}
