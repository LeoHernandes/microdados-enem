import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/logic/answer_score_relation_cubit.dart';
import 'package:microdados_enem_app/data_analysis/logic/answer_score_relation_state.dart';
import 'package:microdados_enem_app/data_analysis/ui/widgets/answer_score_dashboard/bar_char.dart';
import 'package:microdados_enem_app/data_analysis/ui/widgets/answer_score_dashboard/score_summary.dart';

class AnswerScoreDashboard extends HookWidget {
  final int rightAnswers;
  final ExamArea area;

  const AnswerScoreDashboard({
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
            isSuccess:
                (data) => Column(
                  children: [
                    ScoreSummary(
                      minScore: data.minScore,
                      maxScore: data.maxScore,
                      rightAnswers: rightAnswers,
                      area: area,
                    ),
                    SizedBox(height: 20),
                    BarChar(
                      data: data.histogram,
                      area: area,
                      rightAnswers: rightAnswers,
                    ),
                  ],
                ),
          ),
    );
  }
}
