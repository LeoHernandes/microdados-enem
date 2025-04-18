import 'package:flutter/material.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/home/logic/participant_score_state.dart';

class CardBody extends StatelessWidget {
  final ParticipantScoreStateData participantScore;

  const CardBody({super.key, required this.participantScore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Seu desempenho',
          color: AppColors.blackPrimary,
          typography: AppTypography.subtitle1,
        ),
        SizedBox(height: 20),

        _ScoreRow(
          label: 'Linguagens, Códigos e suas Tecnologias',
          value: '663',
        ),
        _TableDivider(),

        _ScoreRow(label: 'Ciências Humanas e suas Tecnologias', value: '648'),
        _TableDivider(),

        _ScoreRow(
          label: 'Ciências da Natureza e suas Tecnologias',
          value: '634,3',
        ),
        _TableDivider(),

        _ScoreRow(label: 'Matemática e suas Tecnologias', value: '869,7'),
        _TableDivider(),

        _ScoreRow(label: 'Redação', value: '920'),
        _TableDivider(),

        Row(
          children: [
            AppText(
              text: 'Média simples: ',
              color: AppColors.blackLight,
              typography: AppTypography.subtitle2,
            ),
            AppText(
              text: '869,7',
              color: AppColors.blackPrimary,
              typography: AppTypography.subtitle2,
            ),
          ],
        ),
      ],
    );
  }
}

class _TableDivider extends StatelessWidget {
  const _TableDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: AppColors.blackLightest, thickness: 0.5, height: 0),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final String label;
  final String value;

  const _ScoreRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: label,
          color: AppColors.blackLight,
          typography: AppTypography.caption,
        ),
        AppText(
          text: value,
          color: AppColors.blackPrimary,
          typography: AppTypography.subtitle2,
        ),
      ],
    );
  }
}
