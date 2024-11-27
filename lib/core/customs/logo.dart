import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpn/core/theme/assets.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.width}) : super(key: key);

  final double? width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.logo,
    );
  }
}
