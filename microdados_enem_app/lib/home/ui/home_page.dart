import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarText: 'Início',
      selectedTab: NavTab.home,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/onboarding/step1.png')),
            const Text(
              'A quantidade de linhas na tabela:',
              style: TextStyle(
                fontFamily: 'Rawline',
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
