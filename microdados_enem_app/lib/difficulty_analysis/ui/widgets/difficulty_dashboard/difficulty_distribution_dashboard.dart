import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/alert/alert.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/generic_error/generic_error.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/skeleton/skeleton.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/difficulty_distribution_cubit.dart';
import 'package:microdados_enem_app/difficulty_analysis/logic/difficulty_distribution_state.dart';
import 'package:microdados_enem_app/difficulty_analysis/ui/widgets/difficulty_dashboard/difficulty_line_chart.dart';
import 'package:microdados_enem_app/difficulty_analysis/ui/widgets/difficulty_dashboard/difficulty_summary.dart';

class DifficultyDistributionDashboard extends HookWidget {
  final ExamArea area;
  final ForeignLanguage? language;

  const DifficultyDistributionDashboard({
    super.key,
    required this.area,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<DifficultyDistributionCubit>().getDifficultyDistributionData(
        context,
        this.area,
        this.language,
      );

      return null;
    }, [this.area, this.language]);

    return BlocBuilder<
      DifficultyDistributionCubit,
      DifficultyDistributionState
    >(
      builder:
          (context, state) => state.when(
            isError:
                (_) => GenericError(
                  text:
                      'Não foi possível carregar as estatísticas relacioandas à distribuição de dificuldade.',
                  refetch:
                      () => context
                          .read<DifficultyDistributionCubit>()
                          .getDifficultyDistributionData(
                            context,
                            this.area,
                            this.language,
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
                (data) => Column(
                  children: [
                    Alert.info(
                      body: AppText(
                        text: 'Dados retirados da prova de cor ${data.color}',
                        typography: AppTypography.body2,
                        color: AppColors.blackPrimary,
                      ),
                    ),
                    SizedBox(height: 20),
                    DifficultySummary(
                      easiestQuestion: data.easiestQuestion,
                      hardestQuestion: data.hardestQuestion,
                    ),
                    SizedBox(height: 20),
                    DifficultyLineChart(data: data.distribution, area: area),
                  ],
                ),
          ),
    );
  }
}
