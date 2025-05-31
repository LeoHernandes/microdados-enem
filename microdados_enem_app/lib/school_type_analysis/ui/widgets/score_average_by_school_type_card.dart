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
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_state.dart';
import 'package:provider/provider.dart';

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
      body: Column(
        children: [
          AppText(
            text: data.privateSchoolScores.averageCH.toString(),
            typography: AppTypography.headline6,
            color: AppColors.blackLight,
          ),
        ],
      ),
    );
  }
}
