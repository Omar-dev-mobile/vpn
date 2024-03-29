import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

class DateConnection extends StatefulWidget {
  const DateConnection({super.key, required this.date});
  final DateTime date;
  @override
  State<DateConnection> createState() => _DateConnectionState();
}

class _DateConnectionState extends State<DateConnection> {
  DateTime currentTime = DateTime.now();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration workDuration = currentTime.difference(widget.date);
    String formattedWorkDuration = formatDuration(workDuration);
    return CommonTextWidget(
      text: formattedWorkDuration,
      size: screenUtil.setSp(18),
      color: Theme.of(context).textTheme.labelLarge!.color,
      fontWeight: FontWeight.w400,
    );
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
