import 'package:flutter/material.dart';
import 'package:syncrosong/styling_guide.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: CircularProgressIndicator(color: AppColors.mainColor));
}
