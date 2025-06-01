import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/generic_error/generic_error.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/skeleton/skeleton.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_state.dart';

class ScoreAverageBySchoolTypeCard extends HookWidget {
  const ScoreAverageBySchoolTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context
          .read<ScoreAverageBySchoolTypeCubit>()
          .getScoreAverageBySchoolTypeData(context);

      return null;
    });

    return BlocBuilder<
      ScoreAverageBySchoolTypeCubit,
      ScoreAverageBySchoolTypeState
    >(
      builder:
          (context, state) => state.when(
            isIdle: Nothing.new,
            isError:
                (_) => GenericError(
                  text:
                      'Não foi possível encontrar os dados das médias de pontuações',
                  refetch:
                      () => context
                          .read<ScoreAverageBySchoolTypeCubit>()
                          .getScoreAverageBySchoolTypeData(context),
                ),
            isLoading: () => Skeleton(height: 250),
            isSuccess: (data) => _CardContent(data: data),
          ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final ScoreAverageBySchoolTypeStateData data;

  const _CardContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              text: 'Média de pontuações por tipo de escola',
              typography: AppTypography.subtitle1,
              color: AppColors.blackPrimary,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bluePrimary,
                ),
              ),
              SizedBox(width: 2),
              AppText(
                color: AppColors.blackPrimary,
                text: 'Escolas privadas',
                typography: AppTypography.caption,
              ),
              SizedBox(width: 10),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blackLightest,
                ),
              ),
              SizedBox(width: 2),
              AppText(
                color: AppColors.blackPrimary,
                text: 'Escolas públicas',
                typography: AppTypography.caption,
              ),
            ],
          ),
          SizedBox(
            height: 220,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 450,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 800,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => AppColors.whitePrimary,
                        tooltipPadding: EdgeInsets.all(2),
                        tooltipMargin: 4,
                        getTooltipItem: (_, _, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY.toStringAsFixed(2),
                            AppTypography.subtitle2.copyWith(
                              color:
                                  rodIndex == 0
                                      ? AppColors.bluePrimary
                                      : AppColors.blackLighter,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        axisNameSize: 20,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget:
                              (value, meta) => SideTitleWidget(
                                child: SizedBox(
                                  width: 80,
                                  child: AppText(
                                    align: TextAlign.center,
                                    text:
                                        _axisToArea[value.toInt()]!.displayName,
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
                          text: 'Pontuação',
                          typography: AppTypography.subtitle2,
                          color: AppColors.blackPrimary,
                        ),
                        axisNameSize: 20,
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget:
                              (value, meta) => SideTitleWidget(
                                meta: meta,
                                space: 4,
                                child: Text(
                                  value.round().toString(),
                                  style: AppTypography.caption,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          interval: 200,
                          reservedSize: 42,
                        ),
                      ),
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                    ),
                    barGroups: [
                      _makeGroupData(
                        1,
                        data.privateSchoolScores.averageLC,
                        data.publicSchoolScores.averageLC,
                      ),
                      _makeGroupData(
                        2,
                        data.privateSchoolScores.averageCH,
                        data.publicSchoolScores.averageCH,
                      ),
                      _makeGroupData(
                        3,
                        data.privateSchoolScores.averageCN,
                        data.publicSchoolScores.averageCN,
                      ),
                      _makeGroupData(
                        4,
                        data.privateSchoolScores.averageMT,
                        data.publicSchoolScores.averageMT,
                      ),
                    ],
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      horizontalInterval: 100,
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<int, ExamArea> get _axisToArea => {
    1: ExamArea.LC,
    2: ExamArea.CH,
    3: ExamArea.CN,
    4: ExamArea.MT,
  };

  BarChartGroupData _makeGroupData(int x, double rod1, double rod2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: rod1,
          width: 20,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: AppColors.bluePrimary,
        ),
        BarChartRodData(
          toY: rod2,
          width: 20,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          color: AppColors.blackLightest,
        ),
      ],
    );
  }
}
