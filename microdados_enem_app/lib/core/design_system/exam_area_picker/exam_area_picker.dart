import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/button/check_button.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';
import 'package:microdados_enem_app/core/enem/foreign_language.dart';

class ExamAreaPicker extends HookWidget {
  final void Function(ExamArea area, ForeignLanguage? language) onChange;
  final ExamArea area;
  final ForeignLanguage? language;
  final bool pickLanguage;

  const ExamAreaPicker({
    super.key,
    required this.area,
    required this.onChange,
    this.language,
    this.pickLanguage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        if (pickLanguage) ...[
          CheckButton(
            checked: area == ExamArea.LC && language == ForeignLanguage.EN,
            text: 'Linguagens | Inglês',
            onCheck: () {
              onChange(ExamArea.LC, ForeignLanguage.EN);
            },
          ),
          CheckButton(
            checked: area == ExamArea.LC && language == ForeignLanguage.ES,
            text: 'Linguagens | Espanhol',
            onCheck: () {
              onChange(ExamArea.LC, ForeignLanguage.ES);
            },
          ),
        ] else
          CheckButton(
            checked: area == ExamArea.LC,
            text: 'Linguagens',
            onCheck: () {
              onChange(ExamArea.LC, null);
            },
          ),
        CheckButton(
          checked: area == ExamArea.CH,
          text: 'Ciências Humanas',
          onCheck: () {
            onChange(ExamArea.CH, null);
          },
        ),
        CheckButton(
          checked: area == ExamArea.MT,
          text: 'Matemática',
          onCheck: () {
            onChange(ExamArea.MT, null);
          },
        ),
        CheckButton(
          checked: area == ExamArea.CN,
          text: 'Ciências da Natureza',
          onCheck: () {
            onChange(ExamArea.CN, null);
          },
        ),
      ],
    );
  }
}
