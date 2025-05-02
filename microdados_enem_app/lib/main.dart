import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/data_analysis/ui/screen/data_analysis.dart';
import 'package:microdados_enem_app/home/ui/screen/home_page.dart';
import 'package:microdados_enem_app/onboarding/ui/screen/onboarding_page.dart';
import 'package:microdados_enem_app/core/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorage = LocalStorage();
  await localStorage.init();

  try {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(fileName: isProduction ? './prod.env' : './dev.env');
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  runApp(
    Provider<LocalStorage>.value(value: localStorage, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = Provider.of<LocalStorage>(context, listen: false);
    final isOnboardingComplete = localStorage.getBool(
      StorageKeys.isOnboardingComplete,
      false,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.whitePrimary),
      initialRoute: isOnboardingComplete ? Routes.home : Routes.onboarding,
      onGenerateRoute:
          (settings) => PageRouteBuilder(
            pageBuilder:
                (_, __, ___) => switch (settings.name) {
                  Routes.onboarding => OnboardingPage(),
                  Routes.home => AppScaffold(
                    appBarText: 'Início',
                    body: HomePage(),
                    selectedTab: NavTab.home,
                  ),
                  Routes.dataAnalysis => AppScaffold(
                    appBarText: 'Análises',
                    body: DataAnalysis(),
                    selectedTab: NavTab.dataAnalysis,
                  ),
                  _ => Nothing(),
                },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
    );
  }
}
