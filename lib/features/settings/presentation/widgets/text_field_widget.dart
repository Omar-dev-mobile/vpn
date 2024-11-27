import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants.dart';
import '../../../../core/theme/theme.dart';

class TextFieldWidgetForAsk extends StatelessWidget {
  const TextFieldWidgetForAsk({
    super.key,
    required this.hintText,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.textAlign = TextAlign.start,
  });

  final String hintText;
  final TextEditingController? controller;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 30,
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      textAlign: textAlign,
      scrollPadding: EdgeInsets.zero,
      cursorColor: kBlack,
      cursorErrorColor: kBlack,
      decoration: InputDecoration(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color ?? kBlack),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          fontSize: screenUtil.setSp(23),
          fontFamily: 'Saira',
          fontWeight: FontWeight.w300,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        filled: true,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color ?? kBlack),
          // borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color ?? kBlack),
          // borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color ?? kBlack),
          // borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color ?? kBlack),
          // borderRadius: BorderRadius.circular(5.0), // Set the border radius
        ),
      ),
    );
  }
}
