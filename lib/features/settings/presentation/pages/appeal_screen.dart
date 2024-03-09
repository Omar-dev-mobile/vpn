import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/common_text_widget.dart';
import '../../../../core/customs/roundedButton.dart';
import '../../../../core/theme/theme.dart';

@RoutePage()
class AppealScreen extends StatelessWidget {
  const AppealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kTransparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.router.pop();
          },
          color: kPrimary,
          iconSize: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check,
                  color: kGreenColor,
                  size: 100,
                ),
                CommonTextWidget(
                  text: "Your appeal has been sent",
                  size: ScreenUtil().setSp(35.0),
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ],
            ),
            screenUtil.setHeight(30).ph,
            Padding(
              padding: const EdgeInsets.only( bottom: 10),
              child: RoundedButton(
                name: "Thanks",
                color: kGreenColor,
                width: 130,
                colorRounded: kGreenColor,
                onPressed: () {
                  context.router.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
