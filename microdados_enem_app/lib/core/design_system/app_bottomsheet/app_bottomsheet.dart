import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/button.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class AppBottomsheet {
  final Widget Function(BuildContext) builder;
  final VoidCallback? onPrimaryButtonTap;
  final String? primaryButtonLabel;

  const AppBottomsheet({
    required this.builder,
    this.onPrimaryButtonTap,
    this.primaryButtonLabel,
  });

  void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.whitePrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              builder(context),
              Visibility(
                visible: onPrimaryButtonTap != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button.terciary(
                      size: Size(80, 36),
                      text: primaryButtonLabel ?? 'ENTENDI',
                      onPressed: onPrimaryButtonTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomsheetTitle extends StatelessWidget {
  final String text;

  const BottomsheetTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppText(
          text: text,
          typography: AppTypography.subtitle1,
          color: AppColors.blackPrimary,
        ),
      ],
    );
  }
}

class BottomsheetBodyText extends StatelessWidget {
  final String text;

  const BottomsheetBodyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: text,
      typography: AppTypography.body2,
      color: AppColors.blackPrimary,
      align: TextAlign.justify,
    );
  }
}
