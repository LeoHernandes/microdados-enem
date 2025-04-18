import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/routes.dart';

class BottomNav extends StatelessWidget {
  final NavTab selectedTab;

  const BottomNav({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
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
          _NavButton(
            icon: Icons.house,
            label: 'Início',
            isSelected: this.selectedTab == NavTab.home,
            onTap:
                () => {
                  if (this.selectedTab != NavTab.home)
                    Navigator.pushNamed(context, Routes.home),
                },
          ),
          _NavButton(
            icon: Icons.person,
            label: 'Meus Dados',
            isSelected: this.selectedTab == NavTab.myInfo,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final void Function() onTap;

  const _NavButton({
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.sizeOf(context).width / 4;

    return Material(
      color: AppColors.blueDarker,
      child: InkWell(
        splashColor: AppColors.blueDark,
        highlightColor: AppColors.bluePrimary,
        onTap: onTap,
        child: SizedBox(
          width: buttonWidth,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color:
                      isSelected
                          ? AppColors.whitePrimary
                          : AppColors.blackLighter,
                  size: 26,
                ),
                AppText(
                  color:
                      isSelected
                          ? AppColors.whitePrimary
                          : AppColors.blackLighter,
                  text: label,
                  typography: AppTypography.subtitle1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
