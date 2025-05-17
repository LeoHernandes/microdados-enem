import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class AnswerScoreBarChart extends StatelessWidget {
  final Map<int, int> data;
  final ExamArea area;
  final int rightAnswers;
  final String minScore;

  const AnswerScoreBarChart({
    super.key,
    required this.data,
    required this.area,
    required this.rightAnswers,
    required this.minScore,
  });

  static const double MAX_BAR_HEIGHT = 300;

  int get maxEntry => data.values.reduce((a, b) => a > b ? a : b);
  int get scoreInterval =>
      data.length > 1 ? data.keys.elementAt(1) - data.keys.elementAt(0) : 0;

  @override
  Widget build(BuildContext context) {
    final barWidth = MediaQuery.sizeOf(context).width / (data.length + 2);

    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Número de participantes por pontuação',
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
          AppText(
            text:
                'Participantes com $rightAnswers acertos em ${area.displayName}',
            typography: AppTypography.caption,
            color: AppColors.blackPrimary,
          ),
          SizedBox(
            height: MAX_BAR_HEIGHT,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxEntry * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 4,
                    getTooltipItem: (_, _, rod, _) {
                      return BarTooltipItem(
                        rod.toY.round().toString(),
                        AppTypography.subtitle1.copyWith(
                          color: AppColors.bluePrimary,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: AppText(
                      text: 'Pontuações',
                      typography: AppTypography.subtitle2,
                      color: AppColors.blackPrimary,
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget:
                          (value, meta) => SideTitleWidget(
                            child: SizedBox(
                              width: barWidth,
                              child: AppText(
                                align: TextAlign.center,
                                text:
                                    scoreInterval != 0
                                        ? '${value.round()} a ${value.round() + scoreInterval}'
                                        : minScore,
                                typography: AppTypography.caption,
                                color: AppColors.blackPrimary,
                              ),
                            ),
                            meta: meta,
                          ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: AppText(
                      text: 'Quantidade de participantes',
                      typography: AppTypography.subtitle2,
                      color: AppColors.blackPrimary,
                    ),
                    axisNameSize: 20,
                  ),
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
                                toY: entry.value.toDouble(),
                                width: barWidth,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                ),
                                color: AppColors.bluePrimary,
                              ),
                            ],
                            showingTooltipIndicators: [0],
                          ),
                        )
                        .toList(),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
