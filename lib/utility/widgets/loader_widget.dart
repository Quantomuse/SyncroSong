import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      );
}
