import 'package:flutter/material.dart';

class ProgressIndicatorCountry extends StatelessWidget {
  const ProgressIndicatorCountry({super.key, required this.progressing});
  final bool progressing;
  @override
  Widget build(BuildContext context) {
    if (progressing) {
      return const LinearProgressIndicator();
    } else {
      return const SizedBox.shrink();
    }
  }
}
