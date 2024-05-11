import 'package:flutter/material.dart';

import '../theme/theme.dart';

class InkWellCircleCustom extends StatelessWidget {
  const InkWellCircleCustom({
    super.key,
    required this.onTap,
    this.child,
  });

  final Function() onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kTransparent,
      child: ClipOval(
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.5),
          highlightColor: Colors.white.withOpacity(0.2),
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
