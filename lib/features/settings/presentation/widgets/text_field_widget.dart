import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants.dart';
import '../../../../core/theme/theme.dart';



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
        cursorHeight:18 ,
        inputFormatters: inputFormatters,
        controller: controller,
        textAlign: textAlign,
        scrollPadding: EdgeInsets.zero,
        cursorColor: kBlack,
        decoration: InputDecoration(
          fillColor: kWhite,
          errorBorder: InputBorder.none,
          hintText: hintText,
          alignLabelWithHint: true,
          hintStyle: TextStyle(
            fontSize: screenUtil.setSp(23),
            fontFamily: 'Saira',
            fontWeight: FontWeight.w300,
            color: kDarkBluishGray,
          ),
          filled: true,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            
            borderRadius: BorderRadius.circular(5.0), // Set the border radius
          ),
          focusedBorder: UnderlineInputBorder
          (
            borderRadius: BorderRadius.circular(5.0), // Set the border radius
          ),
        ),
      ),
    );
  }
}
