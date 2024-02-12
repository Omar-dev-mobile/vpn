import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';
import 'package:vpn/core/theme/theme.dart';

class BuilderBloc<S, E> extends StatelessWidget {
  BuilderBloc({super.key, required this.child, required this.state});
  Widget child;
  dynamic state;

  @override
  Widget build(BuildContext context) {
    if (state is S) {
      return child;
    } else if (state is E) {
      return Center(
          child: CommonTextWidget(
        text: state.error,
        size: screenUtil.setSp(20),
        fontWeight: FontWeight.w500,
        color: kBlack,
      ));
    }
    return const Center(child: CircularProgressIndicator());
  }
}
