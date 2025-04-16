import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:provider/provider.dart';

class SubscriptionNumber extends StatelessWidget {
  const SubscriptionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final localStorage = Provider.of<LocalStorage>(context, listen: false);
    final subscription = localStorage.getString(StorageKeys.subscription, '');

    return Visibility(
      visible: subscription.isNotEmpty,
      child: Row(
        children: [
          Icon(Icons.portrait, color: AppColors.bluePrimary, size: 36),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Número de inscrição',
                typography: AppTypography.caption,
                color: AppColors.blackPrimary,
              ),
              AppText(
                text: subscription,
                typography: AppTypography.body1,
                color: AppColors.blackPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
