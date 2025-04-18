import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/skeleton/skeleton.dart';

class CardBodyLoading extends StatelessWidget {
  const CardBodyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(height: 24, width: 100),
        SizedBox(height: 20),

        Skeleton(height: 20, width: totalWidth),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Skeleton(height: 1, width: totalWidth),
        ),

        Skeleton(height: 20, width: totalWidth),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Skeleton(height: 1, width: totalWidth),
        ),

        Skeleton(height: 20, width: totalWidth),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Skeleton(height: 1, width: totalWidth),
        ),

        Skeleton(height: 20, width: totalWidth),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Skeleton(height: 1, width: totalWidth),
        ),

        Skeleton(height: 20, width: totalWidth),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Skeleton(height: 1, width: totalWidth),
        ),

        Skeleton(height: 20, width: 200),
      ],
    );
  }
}
