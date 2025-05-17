import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/card_button.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/routes.dart';
import 'package:microdados_enem_app/home/logic/participant_score_cubit.dart';
import 'package:microdados_enem_app/home/ui/widgets/subscription_number.dart';
import 'package:microdados_enem_app/home/ui/widgets/user_score_card/user_score_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubscriptionNumber(),
          SizedBox(height: 20),
          BlocProvider(
            create: (_) => ParticipantScoreCubit(),
            child: UserScoreCard(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: DottedDivider(),
          ),
          AppText(
            text: 'Análises',
            typography: AppTypography.headline6,
            color: AppColors.bluePrimary,
          ),
          SizedBox(height: 10),
          CardButton(
            title: '1. Número de acertos e pontuação',
            description:
                'Entenda a relação entre o número de acertos e as pontuações dos participantes em cada área do conhecimento.',
            onTap:
                () => Navigator.pushNamed(context, Routes.answerScoreAnalysis),
          ),
          SizedBox(height: 8),
          CardButton(
            title: '2. Distribuição de dificuldade',
            description:
                'Compare a distribuição e a variância de dificuldade através das questões de cada área do exame.',
            onTap:
                () => Navigator.pushNamed(context, Routes.difficultyAnalysis),
          ),
        ],
      ),
    );
  }
}
