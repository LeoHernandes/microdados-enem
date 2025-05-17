import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const CardButton({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whitePrimary,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.blueLighter,
        highlightColor: AppColors.blueLightest,
        borderRadius: BorderRadius.circular(8),
        splashFactory: InkRipple.splashFactory,
        child: AppCard(
          border: true,
          backgroundColor: Colors.transparent,
          body: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: title,
                    typography: AppTypography.subtitle1,
                    color: AppColors.bluePrimary,
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.75,
                    child: AppText(
                      align: TextAlign.justify,
                      text: description,
                      typography: AppTypography.caption,
                      color: AppColors.blackPrimary,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.bluePrimary,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
