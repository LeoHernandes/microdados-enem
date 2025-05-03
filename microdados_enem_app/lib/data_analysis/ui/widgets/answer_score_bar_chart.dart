import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/logic/answer_score_relation_cubit.dart';
import 'package:microdados_enem_app/data_analysis/logic/answer_score_relation_state.dart';

class AnswerScoreBarChart extends HookWidget {
  final int rightAnswers;
  final ExamArea area;

  const AnswerScoreBarChart({
    super.key,
    required this.rightAnswers,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<AnswerScoreRelationCubit>().getAnswerScoreRelationData(
        context,
        this.rightAnswers,
        this.area,
      );

      return null;
    }, [this.rightAnswers, this.area]);

    return BlocBuilder<AnswerScoreRelationCubit, AnswerScoreRelationState>(
      builder:
          (context, state) => state.when(
            isError: Text.new,
            isIdle: () => Text('idle'),
            isLoading: () => Text('carregando'),
            isSuccess: (data) => _BarChar(data: data.histogram),
          ),
    );
  }
}

class _BarChar extends StatelessWidget {
  final Map<int, int> data;

  const _BarChar({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: BarChart(
        BarChartData(
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
                    color: AppColors.blueLigher,
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
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (value) => BarChartGroupData(
                      x: value.key,
                      barRods: [
                        BarChartRodData(toY: value.value.value.toDouble()),
                      ],
                      showingTooltipIndicators: [value.key],
                    ),
                  )
                  .toList(),
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
        ),
      ),
    );
  }
}
