import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/button/check_button.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class ExamAreaPicker extends HookWidget {
  final ValueChanged<ExamArea> onChange;
  final ExamArea value;

  const ExamAreaPicker({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        CheckButton(
          checked: value == ExamArea.LC,
          text: 'Linguagens',
          onCheck: () {
            onChange(ExamArea.LC);
          },
        ),
        CheckButton(
          checked: value == ExamArea.CH,
          text: 'Ciências Humanas',
          onCheck: () {
            onChange(ExamArea.CH);
          },
        ),
        CheckButton(
          checked: value == ExamArea.MT,
          text: 'Matemática',
          onCheck: () {
            onChange(ExamArea.MT);
          },
        ),
        CheckButton(
          checked: value == ExamArea.CN,
          text: 'Ciências da Natureza',
          onCheck: () {
            onChange(ExamArea.CN);
          },
        ),
      ],
    );
  }
}
