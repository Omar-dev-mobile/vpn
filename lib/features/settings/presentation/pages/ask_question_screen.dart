import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/features/settings/presentation/widgets/text_field_widget.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/common_text_widget.dart';
import '../../../../core/customs/roundedButton.dart';
import '../../../../core/theme/theme.dart';


@RoutePage()
class AskQuestionScreen extends StatelessWidget {
  AskQuestionScreen({super.key});
  final List<String> hintText = ["Message", "Your Name", "Your Mail", "Your Phone"];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20 , right: 20),
              child: IconButton(
                icon:const Icon(Icons.close) ,
                onPressed: () {
                  context.router.pop();

                },
                color: kPrimary,
                iconSize: 30,
              ),
            ),
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
                      screenUtil.setHeight(20).ph,

                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => TextFieldWidgetForAsk(
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
            RoundedButton(name: "Send", color: kPrimary, width: 130, colorRounded: kPrimary, onPressed: (){

              if (_formKey.currentState!.validate()) {
                context.pushRoute(const AppealRoute());
              }

            }

            ),
          ],
        ),
      ),
    );
  }


}
