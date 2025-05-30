import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/app_bottomsheet/app_bottomsheet.dart';
import 'package:microdados_enem_app/core/design_system/app_card/app_card.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/dotted_line/dotted_line.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/local_storage.dart';
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
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  text:
                                      'Régua de dificuldade de ${area.displayName}',
                                  typography: AppTypography.subtitle1,
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
                                      onPrimaryButtonTap:
                                          () => Navigator.pop(context),
                                    ).show(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          AppText(
                            text:
                                'Considerando seu desempenho na prova cor ${data.examColor}',
                            typography: AppTypography.caption,
                            color: AppColors.blackPrimary,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.bluePrimary,
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    color: AppColors.blackPrimary,
                                    text: 'Acerto',
                                    typography: AppTypography.caption,
                                  ),
                                  SizedBox(width: 16),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.bluePrimary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    color: AppColors.blackPrimary,
                                    text: 'Erro',
                                    typography: AppTypography.caption,
                                  ),
                                ],
                              ),
                              AppText(
                                color: AppColors.blackPrimary,
                                text: 'Acertos totais: ${data.rightAnswers}',
                                typography: AppTypography.caption,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          DifficultyRule(data: data.difficultyRule),
                          Center(
                            child: AppText(
                              text: 'Dificuldade das questões',
                              typography: AppTypography.subtitle2,
                              color: AppColors.blackPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            defaultValue: Nothing(),
          ),
    );
  }

  Widget explanationBuilder(BuildContext context) {
    return Column(
      children: [
        BottomsheetTitle(text: 'Para que serve a régua?'),
        SizedBox(height: 8),
        BottomsheetBodyText(
          text:
              'Uma forma comum de visualizar o seu desempenho numa área do conhecimiento é colocar as questões ordenadas pela sua dificuldade - da esquerda para a direita - numa espécie de régua.',
        ),
        SizedBox(height: 8),
        BottomsheetBodyText(
          text:
              'Com ela, é possível avaliar sua coerência pedagógica como participante na prova, isto é, se você acertou questões difíceis somente se também acertou as mais fáceis naquele exame.',
        ),
        SizedBox(height: 8),
        BottomsheetBodyText(
          text:
              'Essa coerência tem impacto direto na sua nota calculada pela TRI e pode dar pistas sobre o motivo da sua pontuação ser maior ou menor de outras pessoas com o mesmo número de acertos.',
        ),
      ],
    );
  }
}

class DifficultyRule extends StatelessWidget {
  final Map<int, bool> data;

  const DifficultyRule({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1500,
          child: ScatterChart(
            ScatterChartData(
              maxY: 1,
              minY: -1,
              minX: -1,
              maxX: 45,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Fácil',
                            typography: AppTypography.caption,
                            color: AppColors.blackLight,
                          ),
                          AppText(
                            text: 'Difícil',
                            typography: AppTypography.caption,
                            color: AppColors.blackLight,
                          ),
                        ],
                      ),
                    ],
                  ),
                  axisNameSize: 25,
                ),
                leftTitles: const AxisTitles(axisNameSize: 20),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              gridData: FlGridData(drawHorizontalLine: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: AppColors.blackLighter),
              ),
              scatterSpots: spots,
              scatterTouchData: ScatterTouchData(
                enabled: true,
                touchSpotThreshold: 5,
                touchTooltipData: ScatterTouchTooltipData(
                  tooltipHorizontalOffset: -80,
                  tooltipBorderRadius: BorderRadius.circular(8),
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  tooltipPadding: EdgeInsets.all(8),
                  getTooltipColor: (_) => AppColors.blueDarker,
                  getTooltipItems:
                      (spot) => ScatterTooltipItem(
                        'Questão ${data.keys.elementAt(spot.x.round())}',
                        textStyle: AppTypography.caption.copyWith(
                          color: AppColors.whitePrimary,
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<ScatterSpot> get spots {
    var index = 0;
    final List<ScatterSpot> list = [];

    data.forEach((key, value) {
      list.add(
        ScatterSpot(
          index.toDouble(),
          0,
          dotPainter:
              value
                  ? FlDotCirclePainter(
                    color: AppColors.bluePrimary,
                    strokeColor: AppColors.bluePrimary,
                    radius: 15,
                    strokeWidth: 1,
                  )
                  : FlDotCirclePainter(
                    color: AppColors.whitePrimary,
                    strokeColor: AppColors.bluePrimary,
                    radius: 15,
                    strokeWidth: 2,
                  ),
        ),
      );
      index++;
    });

    return list;
  }
}
