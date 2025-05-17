import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/generic_error/generic_error.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/skeleton/skeleton.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/answer_score_relation_cubit.dart';
import 'package:microdados_enem_app/answer_score_analysis/logic/answer_score_relation_state.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/answer_score_dashboard/answer_score_bar_chart.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/answer_score_dashboard/empty_dashboard.dart';
import 'package:microdados_enem_app/answer_score_analysis/ui/widgets/answer_score_dashboard/score_summary.dart';

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
            isError:
                (_) => GenericError(
                  text:
                      'Não foi possível carregar as estatísticas relacioandas aos acertos e pontuação do exame.',
                  refetch:
                      () => context
                          .read<AnswerScoreRelationCubit>()
                          .getAnswerScoreRelationData(
                            context,
                            this.rightAnswers,
                            this.area,
                          ),
                ),
            isIdle: Nothing.new,
            isLoading:
                () => Column(
                  children: [
                    Skeleton(height: 100),
                    SizedBox(height: 20),
                    Skeleton(height: 300),
                  ],
                ),
            isSuccess:
                (data) =>
                    data.hasData
                        ? Column(
                          children: [
                            ScoreSummary(
                              minScore: data.minScore,
                              maxScore: data.maxScore,
                              rightAnswers: rightAnswers,
                              area: area,
                            ),
                            SizedBox(height: 20),
                            AnswerScoreBarChart(
                              data: data.histogram,
                              area: area,
                              rightAnswers: rightAnswers,
                              minScore: data.minScore,
                            ),
                          ],
                        )
                        : EmptyDashboard(
                          area: area,
                          rightAnswers: rightAnswers,
                        ),
          ),
    );
  }
}
