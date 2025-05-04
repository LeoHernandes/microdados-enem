import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';

class BarChar extends StatelessWidget {
  final Map<int, int> data;

  const BarChar({super.key, required this.data});

  static const double MAX_BAR_HEIGHT = 300;
  int get maxEntry => data.values.reduce((a, b) => a > b ? a : b);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      height: MAX_BAR_HEIGHT,
      body: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: MAX_BAR_HEIGHT * 1.1,
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 8,
              getTooltipItem: (_, _, rod, _) {
                return BarTooltipItem(
                  rod.toY.round().toString(),
                  const TextStyle(
                    color: AppColors.bluePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget:
                    (_, meta) => SideTitleWidget(
                      child: AppText(
                        text: '',
                        typography: AppTypography.caption,
                        color: AppColors.blackPrimary,
                      ),
                      meta: meta,
                    ),
              ),
            ),
            leftTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
          ),
          barGroups:
              data.entries
                  .map(
                    (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: _normalizeValue(entry.value),
                          width: 20,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: AppColors.bluePrimary,
                        ),
                      ],
                    ),
                  )
                  .toList(),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  double _normalizeValue(int value) {
    return (value / this.maxEntry) * MAX_BAR_HEIGHT;
  }
}
