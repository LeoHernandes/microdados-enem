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

      return () {};
    }, [area]);

    return BlocBuilder<
      ParticipantScoreOnAreaCubit,
      ParticipantScoreOnAreaState
    >(
      builder:
          (context, state) => state.whenOrDefault(
            isSuccess:
                (data) => AppCard(
                  border: true,
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Seu desempenho em ${area.displayName}',
                        typography: AppTypography.subtitle1,
                        color: AppColors.blackPrimary,
                      ),
                      Row(
                        children: [
                          AppText(
                            text: 'Acertos: ',
                            typography: AppTypography.body2,
                            color: AppColors.blackPrimary,
                          ),
                          AppText(
                            text: data.rightAnswersCount,
                            typography: AppTypography.body2,
                            color: AppColors.blueLigher,
                          ),
                          AppText(
                            text: '/45',
                            typography: AppTypography.body2,
                            color: AppColors.blackPrimary,
                          ),
                          SizedBox(
                            height: 18,
                            child: VerticalDivider(
                              color: AppColors.blackLighter,
                              thickness: 1,
                              width: 10,
                              indent: 2,
                            ),
                          ),
                          AppText(
                            text: 'Nota: ',
                            typography: AppTypography.body2,
                            color: AppColors.blackPrimary,
                          ),
                          AppText(
                            text: data.score,
                            typography: AppTypography.body2,
                            color: AppColors.blueLigher,
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
