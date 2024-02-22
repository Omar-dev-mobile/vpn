import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn/core/theme/assets.dart';

class LottieWidget extends StatefulWidget {
  LottieWidget({
    super.key,
    required this.asset,
    this.repeat = true,
    this.plaseholder = const CircularProgressIndicator(),
    this.reverse = false,
    this.animate = true,
  });
  final String asset;
  bool repeat;
  bool reverse;
  bool animate;
  Widget plaseholder;
  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();

    _composition = AssetLottie(widget.asset).load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Lottie(
            composition: composition,
            repeat: widget.repeat,
            reverse: widget.reverse,
            animate: widget.animate,
          );
        } else {
          return widget.plaseholder;
        }
      },
    );
  }
}
