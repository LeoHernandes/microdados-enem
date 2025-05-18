import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class DifficultyLineChart extends StatelessWidget {
  final Map<int, double?> data;
  final ExamArea area;

  const DifficultyLineChart({
    super.key,
    required this.data,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Dificuldade das questões de ${area.displayName}',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  minY: 250,
                  maxY: 750,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: AppColors.blackLighter),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: bottomTitle,
                    leftTitles: leftTitle,
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                  ),
                  lineBarsData: [lineData],
                  lineTouchData: touchTooltip,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AxisTitles get leftTitle => AxisTitles(
    axisNameWidget: AppText(
      text: 'Dificuldade',
      typography: AppTypography.subtitle2,
      color: AppColors.blackPrimary,
    ),
    axisNameSize: 20,
  );

  AxisTitles get bottomTitle => AxisTitles(
    axisNameWidget: AppText(
      text: 'Número da questão',
      typography: AppTypography.subtitle2,
      color: AppColors.blackPrimary,
    ),
    axisNameSize: 20,
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 25,
      getTitlesWidget:
          (value, meta) => SideTitleWidget(
            child: AppText(
              align: TextAlign.center,
              text: value.round().toString(),
              typography: AppTypography.caption,
              color: AppColors.blackPrimary,
            ),
            meta: meta,
          ),
    ),
  );

  LineChartBarData get lineData => LineChartBarData(
    spots:
        data.entries
            .map(
              (entry) =>
                  entry.value != null
                      ? FlSpot(entry.key.toDouble(), entry.value!)
                      : FlSpot.nullSpot,
            )
            .toList(),
    color: AppColors.bluePrimary,
  );

  LineTouchData get touchTooltip => LineTouchData(
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (_) => AppColors.blueDark,
      tooltipBorderRadius: BorderRadius.circular(8),
      fitInsideHorizontally: true,
      fitInsideVertically: true,
      tooltipPadding: EdgeInsets.all(8),
      maxContentWidth: 100,
      getTooltipItems:
          (spots) =>
              spots
                  .map(
                    (spot) => LineTooltipItem(
                      'Questão ${spot.x.round()}: ${spot.y.toStringAsFixed(2)}',
                      AppTypography.subtitle2.copyWith(
                        color: AppColors.whitePrimary,
                      ),
                    ),
                  )
                  .toList(),
    ),
  );
}
