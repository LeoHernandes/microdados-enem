import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_scaffold/app_scaffold.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/home/ui/widgets/subscription_number.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarText: 'Início',
      selectedTab: NavTab.home,
      body: Container(
        decoration: BoxDecoration(color: AppColors.whitePrimary),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            SubscriptionNumber(),
            SizedBox(height: 20),
            UserScoreCard(),
          ],
        ),
      ),
    );
  }
}

class UserScoreCard extends StatelessWidget {
  const UserScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.whitePrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackLightest,
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Seu desempenho',
            color: AppColors.blackPrimary,
            typography: AppTypography.subtitle1,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Linguagens, Códigos e suas Tecnologias',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: '663',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Ciências Humanas e suas Tecnologias',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: '648',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Ciências da Natureza e suas Tecnologias',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: '634,3',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Matemática e suas Tecnologias',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: '869,7',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Redação',
                color: AppColors.blackLight,
                typography: AppTypography.caption,
              ),
              AppText(
                text: '920',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: AppColors.blackLightest,
              thickness: 0.5,
              height: 0,
            ),
          ),
          Row(
            children: [
              AppText(
                text: 'Média simples: ',
                color: AppColors.blackLight,
                typography: AppTypography.subtitle2,
              ),
              AppText(
                text: '869,7',
                color: AppColors.blackPrimary,
                typography: AppTypography.subtitle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
