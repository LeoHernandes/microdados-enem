import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? radius;

  const Skeleton({
    super.key,
    required this.height,
    required this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1800),
      baseColor: AppColors.blackLightest,
      highlightColor: AppColors.whitePrimary,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.blackLightest,
          borderRadius: radius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
