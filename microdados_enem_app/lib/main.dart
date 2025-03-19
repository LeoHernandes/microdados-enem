import 'package:flutter/material.dart';
import 'package:microdados_enem_app/entrypoint/dotenv_initializer.dart';
import 'package:microdados_enem_app/home/ui/home_page.dart';

Future<void> main() async {
  AppDotenv.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const HomePage(),
    );
  }
}
