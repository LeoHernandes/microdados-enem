import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/alert/alert.dart';
import 'package:microdados_enem_app/core/design_system/app_text/app_text.dart';
import 'package:microdados_enem_app/core/design_system/nothing/nothing.dart';
import 'package:microdados_enem_app/core/design_system/styles/colors.dart';
import 'package:microdados_enem_app/core/design_system/styles/typography.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/data_analysis/logic/canceled_questions_count_cubit.dart';
import 'package:microdados_enem_app/data_analysis/logic/canceled_questions_count_state.dart';

class CanceledQuestionsAlert extends HookWidget {
  final ExamArea area;

  const CanceledQuestionsAlert({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CanceledQuestionsCountCubit>().getCanceledQuestionsCountData(
        context,
        area,
        false,
      );

      return null;
    }, [area]);

    return BlocBuilder<
      CanceledQuestionsCountCubit,
      CanceledQuestionsCountState
    >(
      builder:
          (context, state) => state.whenOrDefault(
            isSuccess:
                (data) =>
                    data.count == '0'
                        ? Nothing()
                        : Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Alert.info(
                            body: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.info_outline, size: 14),
                                    SizedBox(width: 4),
                                    AppText(
                                      text:
                                          'A prova de ${area.displayName} teve ${data.count} ${data.count == '1' ? 'questão anulada' : 'questões anuladas'}',
                                      typography: AppTypography.body2,
                                      color: AppColors.blackPrimary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
            defaultValue: Nothing(),
          ),
    );
  }
}
