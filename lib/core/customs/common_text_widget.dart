import 'package:flutter/material.dart';

import '../theme.dart';

class CommonTextWidget extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double? size;
  final double? height;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final bool? underline;
  final bool? softWrap;

  const CommonTextWidget({
    Key? key,
    required this.text,
    this.size = 16,
    this.fontWeight = FontWeight.w300,
    this.color = kBlack,
    this.height,
    this.textAlign,
    this.overflow,
    this.decoration,
    this.maxLines,
    this.fontFamily = 'Saira',
    this.underline,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontWeight: fontWeight,
            fontSize: size,
            height: height,
            decoration:
                underline == null ? decoration : TextDecoration.underline,
            color: color,
            fontFamily: fontFamily,
          ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
