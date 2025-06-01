import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/exam_area_picker/exam_area_picker.dart';
import 'package:microdados_enem_app/core/design_system/generic_error/generic_error.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/skeleton/skeleton.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_distribution_by_school_type_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_distribution_by_school_type_state.dart';

class ScoreDistributionBySchoolTypeCard extends HookWidget {
  const ScoreDistributionBySchoolTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedArea = useState<ExamArea>(ExamArea.LC);

    useEffect(() {
      context
          .read<ScoreDistributionBySchoolTypeCubit>()
          .getScoreDistributionBySchoolTypeData(context, selectedArea.value);

      return null;
    }, [selectedArea.value]);

    return Column(
      children: [
        ExamAreaPicker(
          onChange: (area, _) => selectedArea.value = area,
          area: selectedArea.value,
        ),
        SizedBox(height: 20),
        BlocBuilder<
          ScoreDistributionBySchoolTypeCubit,
          ScoreDistributionBySchoolTypeState
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
                              .read<ScoreDistributionBySchoolTypeCubit>()
                              .getScoreDistributionBySchoolTypeData(
                                context,
                                selectedArea.value,
                              ),
                    ),
                isLoading: () => Skeleton(height: 250),
                isSuccess: (data) => _CardContent(data: data),
              ),
        ),
      ],
    );
  }
}

class _CardContent extends StatelessWidget {
  final ScoreDistributionBySchoolTypeStateData data;

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
              text: 'Distribuição de pontuações por tipo de escola',
              typography: AppTypography.subtitle1,
              color: AppColors.blackPrimary,
            ),
          ),
          SizedBox(height: 20),
          AppText(
            text: data.privateSchoolDistribution.entries.first.value.toString(),
            typography: AppTypography.subtitle1,
            color: AppColors.blackPrimary,
          ),
        ],
      ),
    );
  }
}
