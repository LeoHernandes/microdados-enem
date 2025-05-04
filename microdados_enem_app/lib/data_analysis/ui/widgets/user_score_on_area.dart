import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/data_analysis/logic/participant_score_on_area_cubit.dart';
import 'package:microdados_enem_app/data_analysis/logic/participant_score_on_area_state.dart';
import 'package:provider/provider.dart';

class UserScoreOnArea extends HookWidget {
  final ExamArea area;

  const UserScoreOnArea({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final localStorage = Provider.of<LocalStorage>(context, listen: false);
      final id = localStorage.getString(StorageKeys.subscription, '');

      if (id.isNotEmpty) {
        context
            .read<ParticipantScoreOnAreaCubit>()
            .getParticipantScoreOnAreaData(context, id, area);
      }

      return null;
    }, [area]);

    return BlocBuilder<
      ParticipantScoreOnAreaCubit,
      ParticipantScoreOnAreaState
    >(
      builder:
          (context, state) => state.whenOrDefault(
            isSuccess:
                (data) => AppCard(
                  shadow: true,
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          AppText(
                            text: 'Seu desempenho em ${area.displayName}',
                            typography: AppTypography.subtitle1,
                            color: AppColors.blackPrimary,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    startDegreeOffset: 270,
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 45,
                                    sections: [
                                      PieChartSectionData(
                                        value:
                                            data.rightAnswersCount.toDouble(),
                                        color: AppColors.bluePrimary,
                                        radius: 25,
                                        title: '',
                                      ),
                                      PieChartSectionData(
                                        value:
                                            (45 - data.rightAnswersCount)
                                                .toDouble(),
                                        color: AppColors.blackLightest,
                                        radius: 25,
                                        title: '',
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(
                                      text: '${data.rightAnswersCount}/45',
                                      typography: AppTypography.headline6,
                                      color: AppColors.blackPrimary,
                                    ),
                                    AppText(
                                      text:
                                          '${(data.rightAnswersCount * 100 / 45).toStringAsFixed(1)}%',
                                      typography: AppTypography.caption,
                                      color: AppColors.blackLighter,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                text: 'Nota final',
                                typography: AppTypography.headline6,
                                color: AppColors.blackLighter,
                              ),
                              AppText(
                                text: data.score,
                                typography: AppTypography.headline6,
                                color: AppColors.blackPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            defaultValue: Nothing(),
          ),
    );
  }
}
