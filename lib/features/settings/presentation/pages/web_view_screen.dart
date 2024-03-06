import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



@RoutePage()
class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen( this.url , {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: WebViewController()..loadRequest(Uri.parse(url)),
        ));
  }
}