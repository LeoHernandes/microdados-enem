import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/bottom_nav.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

enum NavTab {
  home,
  answerScoreAnalysis,
  difficultyAnalysis,
  schoolTypeAnalysis,
}

class AppScaffold extends StatelessWidget {
  final String appBarText;
  final Widget body;
  final NavTab selectedTab;

  const AppScaffold({
    super.key,
    required this.appBarText,
    required this.body,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.whitePrimary,
        backgroundColor: AppColors.whitePrimary,
        shadowColor: AppColors.blackPrimary.withAlpha(150),
        elevation: 1,
        title: AppText(
          color: AppColors.bluePrimary,
          text: appBarText,
          typography: AppTypography.headline6,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: body,
        ),
      ),
      bottomNavigationBar: SafeArea(child: BottomNav(selectedTab: selectedTab)),
    );
  }
}
