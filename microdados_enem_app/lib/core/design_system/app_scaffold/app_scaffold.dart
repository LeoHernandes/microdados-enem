import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

enum NavTab { home, myInfo }

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
        surfaceTintColor: AppColors.whitePrimary,
        backgroundColor: AppColors.whitePrimary,
        shadowColor: AppColors.blackLight,
        elevation: 1,
        title: AppText(
          color: AppColors.bluePrimary,
          text: appBarText,
          typography: AppTypography.headline6,
        ),
      ),
      body: body,
      bottomNavigationBar: _BottomNav(selectedTab: selectedTab),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final NavTab selectedTab;

  const _BottomNav({required this.selectedTab});

  Color get _homeTabColor =>
      this.selectedTab == NavTab.home
          ? AppColors.whitePrimary
          : AppColors.blackLighter;

  Color get _myInfoTabColor =>
      this.selectedTab == NavTab.myInfo
          ? AppColors.whitePrimary
          : AppColors.blackLighter;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.sizeOf(context).width / 4;

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.blueDarker,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackLighter,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: buttonWidth,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.house, color: _homeTabColor, size: 26),
                  AppText(
                    color: _homeTabColor,
                    text: 'Início',
                    typography: AppTypography.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: buttonWidth,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: _myInfoTabColor, size: 26),
                  AppText(
                    color: _myInfoTabColor,
                    text: 'Meus Dados',
                    typography: AppTypography.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
