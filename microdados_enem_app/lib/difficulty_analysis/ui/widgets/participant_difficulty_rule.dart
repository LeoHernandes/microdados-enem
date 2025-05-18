import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
import 'package:microdados_enem_app/difficulty_analysis/data/models.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/participant_pedagogical_coherence_cubit.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/participant_pedagogical_coherence_state.dart';
import 'package:provider/provider.dart';

class ParticipantDifficultyRule extends HookWidget {
  final ExamArea area;

  const ParticipantDifficultyRule({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final localStorage = Provider.of<LocalStorage>(context, listen: false);
      final id = localStorage.getString(StorageKeys.subscription, '');

      if (id.isNotEmpty) {
        context
            .read<ParticipantPedagogicalCoherenceCubit>()
            .getParticipantPedagogicalCoherenceData(context, id, this.area);
      }

      return null;
    }, [this.area]);

    return BlocBuilder<
      ParticipantPedagogicalCoherenceCubit,
      ParticipantPedagogicalCoherenceState
    >(
      builder:
          (context, state) => state.whenOrDefault(
            isSuccess:
                (data) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: DottedDivider(),
                    ),
                    AppCard(
                      shadow: true,
                      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: '${data.examColor} - ${data.rightAnswers}',
                            typography: AppTypography.subtitle2,
                            color: AppColors.blackPrimary,
                          ),
                          SizedBox(height: 10),
                          DifficultyRule(data: data.difficultyRule),
                        ],
                      ),
                    ),
                  ],
                ),
            defaultValue: Nothing(),
          ),
    );
  }
}

class DifficultyRule extends StatelessWidget {
  final Map<double, QuestionHit> data;

  const DifficultyRule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: '${data.entries.first.key} - ${data.entries.first.value}',
      typography: AppTypography.body2,
      color: AppColors.redPrimary,
    );
  }
}
