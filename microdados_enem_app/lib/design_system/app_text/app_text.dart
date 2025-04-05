import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle typography;
  final Color color;

  const AppText({
    super.key,
    required this.text,
    required this.typography,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: typography.copyWith(color: color));
  }
}
