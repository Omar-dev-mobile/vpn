import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speed_test_dart/classes/server.dart';
import 'package:speed_test_dart/speed_test_dart.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/customs/common_text_widget.dart';

class NetworkSpeedChecker extends StatefulWidget {
  const NetworkSpeedChecker({super.key, required this.isOnline});
  final bool isOnline;
  @override
  State<NetworkSpeedChecker> createState() => _NetworkSpeedCheckerState();
}

class _NetworkSpeedCheckerState extends State<NetworkSpeedChecker> {
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  @override
  void dispose() {
    super.dispose();
  }

  double downloadRate = 0;
  double uploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  Future<void> setBestServers() async {
    final settings = await tester.getSettings();
    final servers = settings.servers;

    final best = await tester.getBestServers(
      servers: servers,
    );
    setStateBinding(() {
      bestServersList = best;
      readyToTest = true;
    });
  }

  Future<void> _testUploadSpeed() async {
    setStateBinding(() {
      loadingUpload = true;
    });

    final upload = await tester.testUploadSpeed(servers: bestServersList);
    setStateBinding(() {
      uploadRate = upload;
      loadingUpload = false;
    });
  }

  void setStateBinding(Function() fn) {
    if (mounted) {
      setState(() {
        fn();
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (bestServersList.isEmpty) {
        await setBestServers();
      }
      if (uploadRate == 0) _testUploadSpeed();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color? displaySmall = Theme.of(context).textTheme.displaySmall!.color;

    return widget.isOnline
        ? FutureBuilder(
            future: tester.testUploadSpeed(servers: bestServersList),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    CommonTextWidget(
                      text: snapshot.data?.toStringAsFixed(1) ?? "",
                      size: 28,
                      color: primaryColor,
                    ),
                    CommonTextWidget(
                      text: 'MBps',
                      size: 16,
                      color: displaySmall,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            })
        : const SizedBox.shrink();
  }
}
