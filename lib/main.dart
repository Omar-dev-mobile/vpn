import 'package:flutter/material.dart';
import 'package:vpn/app.dart';
import 'package:vpn/core/init_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitApp.initialize();
  runApp(const VpnApp());
}

