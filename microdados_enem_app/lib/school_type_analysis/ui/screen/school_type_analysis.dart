import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdados_enem_app/core/design_system/app_bottomsheet/app_bottomsheet.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/school_type_distribution_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_average_by_school_type_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/logic/score_distribution_by_school_type_cubit.dart';
import 'package:microdados_enem_app/school_type_analysis/ui/widgets/school_type_distribution_card.dart';
import 'package:microdados_enem_app/school_type_analysis/ui/widgets/score_average_by_school_type_card.dart';
import 'package:microdados_enem_app/school_type_analysis/ui/widgets/score_distribution_by_school_type_card.dart';

class SchoolTypeAnalysis extends StatelessWidget {
  const SchoolTypeAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AppText(
                      text: 'Escolas públicas e privadas',
                      typography: AppTypography.headline6,
                      color: AppColors.blackPrimary,
                    ),
                  ),
                  AppIconButton(
                    size: 22,
                    iconSize: 12,
                    tooltip: 'Ajuda',
                    icon: Icons.question_mark_rounded,
                    onTap:
                        () => AppBottomsheet(
                          builder: explanationBuilder,
                          onPrimaryButtonTap: () => Navigator.pop(context),
                        ).show(context),
                  ),
                ],
              ),
              SizedBox(height: 25),
              BlocProvider(
                create: (_) => SchoolTypeDistributionCubit(),
                child: SchoolTypeDistributionCard(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: DottedDivider(),
              ),
              BlocProvider(
                create: (_) => ScoreAverageBySchoolTypeCubit(),
                child: ScoreAverageBySchoolTypeCard(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: DottedDivider(),
              ),
              BlocProvider(
                create: (_) => ScoreDistributionBySchoolTypeCubit(),
                child: ScoreDistributionBySchoolTypeCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget explanationBuilder(BuildContext context) {
    return Column(
      children: [
        BottomsheetTitle(text: 'Como funciona?'),
        SizedBox(height: 8),
        BottomsheetBodyText(
          text:
              'Nessa análise, você verá múltiplos dados para comparações entre o desempenho de alunos de escolas públicas e privadas.',
        ),
        SizedBox(height: 8),

        BottomsheetBodyText(
          text:
              'Foram inclusos alunos que ainda estão cursando ou que já completaram o Ensino Médio, misturando provas de primeira e segunda aplicação para fazer um apanhado geral.',
        ),
      ],
    );
  }
}
