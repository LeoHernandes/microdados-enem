import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';

class Alert extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;

  const Alert.info({super.key, required this.body})
    : this.backgroundColor = AppColors.blueLighter;

  @override
  Widget build(BuildContext context) {
    return AppCard(shadow: true, backgroundColor: backgroundColor, body: body);
  }
}
