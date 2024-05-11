import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/theme/theme.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
  });
  final String hintText;
  TextEditingController? controller;
  TextAlign textAlign;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        cursorHeight: 18,
        inputFormatters: inputFormatters,
        controller: controller,
        textAlign: textAlign,
        scrollPadding: EdgeInsets.zero,
        cursorColor: kBlack,
        decoration: InputDecoration(
          fillColor: kLightGray,
          errorBorder: InputBorder.none,
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: TextStyle(
            fontSize: screenUtil.setSp(14),
            fontFamily: 'Inter',
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
          filled: true,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5.0), // Set the border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5.0), // Set the border radius
          ),
        ),
      ),
    );
  }
}
