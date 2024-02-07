import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/customs/logo.dart';
import 'package:vpn/core/theme/assets.dart';
import 'package:vpn/features/tarif/presentation/widgets/text_field_widget.dart';

class CardPayWidget extends StatelessWidget {
  const CardPayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Logo(),
              const Spacer(),
              SvgPicture.asset(Assets.close)
            ],
          ),
          17.ph,
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFieldWidget(
                          hintText: '0000 0000 0000 0000',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextFieldWidget(
                          hintText: '•••',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              hintText: '01',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFieldWidget(
                              hintText: '23',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CommonTextWidget(
                      text: 'Pay',
                      color: Theme.of(context).disabledColor,
                      size: screenUtil.setSp(22),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Roboto',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
