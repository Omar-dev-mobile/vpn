import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/common_text_widget.dart';
import '../../../../core/customs/roundedButton.dart';
import '../../../../core/theme/theme.dart';
import '../../../tarif/presentation/widgets/text_field_widget.dart';


class AskQuestionScreen extends StatelessWidget {
  AskQuestionScreen({super.key});
  final List<String> hintText = ["Message", "Your Name", "Your Mail", "Your Phone"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CommonTextWidget(
                  text: "Ask a question",
                  size: ScreenUtil().setSp(35.0),
                    color:Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color,
                  fontWeight: FontWeight.w500,
                ),
                    screenUtil.setHeight(80).ph,

                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => TextFieldWidget(
                              hintText: hintText[index],
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 60,
                            ),
                        itemCount: 4),
                  ],
                ),
              ),
            ),
          ),
          screenUtil.setHeight(20).ph,
          const RoundedButton(name: "Send", color: kPrimary, width: 130, colorRounded: kPrimary,),
        ],
      ),
    );
  }


}
