import '../locator.dart';

class InitApp {
  static Future<void> initialize() async {
    await setupLocator();
  }
}
