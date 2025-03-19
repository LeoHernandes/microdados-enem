import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppDotenv {
  static void initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(fileName: isProduction ? './prod.env' : './dev.env');
  }
}
