import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/snack_bar.dart';
import 'package:vpn/features/settings/data/models/ask_question_model.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_cubit.dart';
import 'package:vpn/features/settings/presentation/cubit/setting_state.dart';
import 'package:vpn/features/settings/presentation/widgets/text_field_widget.dart';
import 'package:vpn/locator.dart';
import 'package:vpn/translations/locate_keys.g.dart';

import '../../../../core/constants.dart';
import '../../../../core/customs/common_text_widget.dart';
import '../../../../core/customs/roundedButton.dart';
import '../../../../core/theme/theme.dart';

@RoutePage()
class AskQuestionScreen extends StatelessWidget {
  AskQuestionScreen({super.key});

  final List<String> hintText = [
    LocaleKeys.message.tr(),
    LocaleKeys.yourName.tr(),
    LocaleKeys.yourEmail.tr()
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    3,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocProvider(
          create: (context) => SettingCubit(locator()),
          child: BlocConsumer<SettingCubit, SettingState>(
            listener: (context, state) {
              if (state is AskQuestionSuccessState) {
                context.replaceRoute(const AppealRoute());
              } else if (state is AskQuestionErrorState) {
                CustomSnackBar.badSnackBar(context, state.error);
              }
            },
            builder: (context, state) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 10, right: 20),
                    child: IconButton(
                      icon: const Icon(Icons.close),
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
                              text: LocaleKeys.askAQuestion.tr(),
                              size: ScreenUtil().setSp(35.0),
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontWeight: FontWeight.w500,
                            ),
                            CommonTextWidget(
                              text: LocaleKeys.yourPrivacyTopPriority.tr(),
                              color: kGreyA4AAAA,
                              size: screenUtil.setSp(18),
                              fontWeight: FontWeight.w500,
                            ),
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 30),
                                itemBuilder: (context, index) =>
                                    TextFieldWidgetForAsk(
                                      hintText: hintText[index],
                                      controller: controllers[index],
                                      validator: (index == 2)
                                          ? validateEmail
                                          : (value) {
                                              print(value);
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return LocaleKeys
                                                    .pleaseEnterSomeText
                                                    .tr();
                                              }
                                              return null;
                                            },
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 0,
                                    ),
                                itemCount: 3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  screenUtil.setHeight(20).ph,
                  RoundedButton(
                    name: LocaleKeys.send.tr(),
                    color: kPrimary,
                    width: 130,
                    isLoading: state is AskQuestionLoadingState,
                    colorRounded: kPrimary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        SettingCubit.get(context).leaveFeedback(
                            AskQuestionModel(controllers[1].text,
                                controllers[2].text, controllers[0].text));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
