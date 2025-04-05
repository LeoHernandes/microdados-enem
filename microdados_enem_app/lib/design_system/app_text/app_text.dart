import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle typography;
  final Color color;
  final TextAlign? align;

  const AppText({
    super.key,
    required this.text,
    required this.typography,
    required this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: typography.copyWith(color: color),
      textAlign: align,
    );
  }
}
