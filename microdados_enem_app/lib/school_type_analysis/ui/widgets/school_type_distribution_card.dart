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
import 'package:microdados_enem_app/school_type_analysis/logic/school_type_distribution_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/school_type_distribution_state.dart';

class SchoolTypeDistributionCard extends HookWidget {
  const SchoolTypeDistributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<SchoolTypeDistributionCubit>().getSchoolTypeDistributionData(
        context,
      );

      return null;
    });

    return BlocBuilder<
      SchoolTypeDistributionCubit,
      SchoolTypeDistributionState
    >(
      builder:
          (context, state) => state.when(
            isIdle: Nothing.new,
            isLoading: () => Skeleton(height: 200),
            isError:
                (_) => GenericError(
                  text:
                      'Não foi possível carregar os dados da quantidade de alunos por tipo de escola',
                  refetch:
                      () => context
                          .read<SchoolTypeDistributionCubit>()
                          .getSchoolTypeDistributionData(context),
                ),
            isSuccess: (data) {
              final allParticipants =
                  data.privateCount + data.publicCount + data.unknownCount;

              return AppCard(
                shadow: true,
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: 'Quantidade de alunos por tipo de escola',
                          typography: AppTypography.subtitle1,
                          color: AppColors.blackPrimary,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: PieChart(
                            PieChartData(
                              startDegreeOffset: 270,
                              centerSpaceRadius: 0,
                              sections: [
                                PieChartSectionData(
                                  value: data.unknownCount.toDouble(),
                                  color: AppColors.blackLight,
                                  radius: 75,
                                  badgeWidget: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whitePrimary,
                                      border: Border.all(
                                        color: AppColors.blackLight,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text:
                                            (data.unknownCount *
                                                    100 /
                                                    allParticipants)
                                                .toStringAsFixed(2) +
                                            '%',
                                        typography: AppTypography.caption,
                                        color: AppColors.blackPrimary,
                                      ),
                                    ),
                                  ),
                                  badgePositionPercentageOffset: 1,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value: data.publicCount.toDouble(),
                                  color: AppColors.blackLightest,
                                  radius: 75,
                                  badgeWidget: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whitePrimary,
                                      border: Border.all(
                                        color: AppColors.blackLightest,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text:
                                            (data.publicCount *
                                                    100 /
                                                    allParticipants)
                                                .toStringAsFixed(2) +
                                            '%',
                                        typography: AppTypography.caption,
                                        color: AppColors.blackPrimary,
                                      ),
                                    ),
                                  ),
                                  badgePositionPercentageOffset: 1,
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value: data.privateCount.toDouble(),
                                  color: AppColors.bluePrimary,
                                  radius: 75,
                                  badgeWidget: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.whitePrimary,
                                      border: Border.all(
                                        color: AppColors.bluePrimary,
                                      ),
                                    ),
                                    child: Center(
                                      child: AppText(
                                        text:
                                            (data.privateCount *
                                                    100 /
                                                    allParticipants)
                                                .toStringAsFixed(2) +
                                            '%',
                                        typography: AppTypography.caption,
                                        color: AppColors.blackPrimary,
                                      ),
                                    ),
                                  ),
                                  badgePositionPercentageOffset: 1,
                                  showTitle: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                            Row(
                              children: [
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
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blackLight,
                                  ),
                                ),
                                SizedBox(width: 2),
                                AppText(
                                  color: AppColors.blackPrimary,
                                  text: 'Não informado',
                                  typography: AppTypography.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
    );
  }
}
