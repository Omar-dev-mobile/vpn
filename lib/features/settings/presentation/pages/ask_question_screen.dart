import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/presentation/cubit/ask_question_cubit.dart';
import 'package:vpn/features/settings/presentation/cubit/ask_question_state.dart';
import 'package:vpn/features/settings/presentation/widgets/text_field_widget.dart';
import 'package:vpn/locator.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/common_text_widget.dart';
import '../../../../core/customs/roundedButton.dart';
import '../../../../core/theme/theme.dart';


@RoutePage()
class AskQuestionScreen extends StatelessWidget {
  AskQuestionScreen({super.key});
  final List<String> hintText = ["Message", "Your Name", "Your Mail"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    3, (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AskQuestionCubit(locator()),
        child : BlocConsumer<AskQuestionCubit , AskQuestionState>(
          listener: (context, state) {
        
          },
          builder: (context, state) => Form(
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
                                    controller:controllers[index],
                                  ),
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 60,
                                  ),
                              itemCount: 3),
                        ],
                      ),
                    ),
                  ),
                ),
                screenUtil.setHeight(20).ph,
                RoundedButton(name: "Send", color: kPrimary, width: 130, colorRounded: kPrimary, onPressed: (){
        
                  if (_formKey.currentState!.validate()) {
        
                    AskQuestionCubit.get(context).leaveFeedback( AskQuestionModel(controllers[1].text, controllers[2].text, controllers[0].text));

                    if(state is AskQuestionSuccessState){
                      context.pushRoute(const AppealRoute());
                    }
                    else if (state is AskQuestionErrorState){
                      print(state.error);
                    }
        
                  }
        
                }
        
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}