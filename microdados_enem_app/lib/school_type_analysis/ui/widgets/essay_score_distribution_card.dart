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
import 'package:microdados_enem_app/school_type_analysis/logic/essay_score_distribution_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/essay_score_distribution_state.dart';

class EssayScoreDistributionCard extends HookWidget {
  const EssayScoreDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<EssayScoreDistributionCubit>().getEssayScoreDistributionData(
        context,
      );

      return null;
    });

    return Column(
      children: [
        BlocBuilder<EssayScoreDistributionCubit, EssayScoreDistributionState>(
          builder:
              (context, state) => state.when(
                isIdle: Nothing.new,
                isError:
                    (_) => GenericError(
                      text:
                          'Não foi possível encontrar os dados das médias de pontuações',
                      refetch:
                          () => context
                              .read<EssayScoreDistributionCubit>()
                              .getEssayScoreDistributionData(context),
                    ),
                isLoading: () => Skeleton(height: 250),
                isSuccess: (data) => _CardContent(data: data),
              ),
        ),
      ],
    );
  }
}

enum VisualizationMode { all, public, private }

class _CardContent extends HookWidget {
  final EssayScoreDistributionStateData data;

  const _CardContent({required this.data});

  int get _allPublic =>
      data.publicSchoolDistribution.values.reduce((a, b) => a + b);

  int get _allPrivate =>
      data.privateSchoolDistribution.values.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final visualizationMode = useState<VisualizationMode>(
      VisualizationMode.all,
    );

    return AppCard(
      shadow: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              text: 'Distribuição de pontuação na redação por tipo de escola',
              typography: AppTypography.subtitle1,
              color: AppColors.blackPrimary,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap:
                    () => {
                      if (visualizationMode.value == VisualizationMode.private)
                        {visualizationMode.value = VisualizationMode.all}
                      else
                        {visualizationMode.value = VisualizationMode.private},
                    },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        visualizationMode.value == VisualizationMode.private
                            ? AppColors.blackLightest
                            : AppColors.whitePrimary,
                    border: Border.all(color: AppColors.blackLightest),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
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
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap:
                    () => {
                      if (visualizationMode.value == VisualizationMode.public)
                        {visualizationMode.value = VisualizationMode.all}
                      else
                        {visualizationMode.value = VisualizationMode.public},
                    },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        visualizationMode.value == VisualizationMode.public
                            ? AppColors.blackLightest
                            : AppColors.whitePrimary,
                    border: Border.all(color: AppColors.blackLightest),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blackLighter,
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
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: 450,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 40,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        fitInsideVertically: true,
                        getTooltipColor: (group) => AppColors.whitePrimary,
                        tooltipPadding: EdgeInsets.all(2),
                        tooltipMargin: 4,
                        getTooltipItem: (_, _, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.toY.toStringAsFixed(2) + '%',
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
                        axisNameWidget: AppText(
                          text: 'Pontuações agregadas',
                          typography: AppTypography.subtitle2,
                          color: AppColors.blackPrimary,
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget:
                              (value, meta) => SideTitleWidget(
                                child: SizedBox(
                                  width: 80,
                                  child: AppText(
                                    align: TextAlign.center,
                                    text: value.round().toString(),
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
                          text: 'Quantidade de alunos (%)',
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
                          interval: 10,
                          reservedSize: 30,
                        ),
                      ),
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                    ),
                    barGroups: _getBarChartGroupsData(
                      data.privateSchoolDistribution,
                      data.publicSchoolDistribution,
                      visualizationMode.value,
                    ),
                    gridData: FlGridData(
                      drawVerticalLine: false,
                      horizontalInterval: 10,
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

  List<BarChartGroupData> _getBarChartGroupsData(
    Map<int, int> data1,
    Map<int, int> data2,
    VisualizationMode mode,
  ) {
    final entriesCount = data1.length;
    final groupsData = List<BarChartGroupData>.empty(growable: true);

    for (int i = 0; i < entriesCount; i++) {
      groupsData.add(
        BarChartGroupData(
          x: data1.keys.elementAt(i),
          barRods: [
            BarChartRodData(
              toY: data1.values.elementAt(i).toDouble() * 100 / _allPrivate,
              width:
                  mode == VisualizationMode.all
                      ? 12
                      : mode == VisualizationMode.private
                      ? 20
                      : 0,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              color: AppColors.bluePrimary,
            ),
            BarChartRodData(
              toY: data2.values.elementAt(i).toDouble() * 100 / _allPublic,
              width:
                  mode == VisualizationMode.all
                      ? 12
                      : mode == VisualizationMode.public
                      ? 20
                      : 0,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
              color: AppColors.blackLightest,
            ),
          ],
        ),
      );
    }

    return groupsData;
  }
}
