import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double? width;
  final BorderRadius? radius;

  const Skeleton({super.key, required this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1800),
      baseColor: AppColors.blackPrimary.withAlpha(50),
      highlightColor: AppColors.whitePrimary,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.blackPrimary.withAlpha(50),
          borderRadius: radius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
