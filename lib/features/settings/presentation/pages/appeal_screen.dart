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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
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
          const Spacer(),
          Padding(
        padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check,
                  color: kGreenColor,
                  size: 100,
                
                ),
                CommonTextWidget(text: "Your appeal has been sent", size:  ScreenUtil().setSp(35.0), fontWeight: FontWeight.w500,color:Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color,),
              ],
            ),
          ),
          screenUtil.setHeight(30).ph,
          const RoundedButton(name: "Thanks", color:kGreenColor , width: 130, colorRounded: kGreenColor,)
          
        ],
      ),
    );
  }
}


