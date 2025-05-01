import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/button/check_button.dart';
import 'package:microdados_enem_app/core/enem/exam_area.dart';

class ExamAreaPicker extends HookWidget {
  final ValueChanged<ExamArea> onAreaSelect;

  const ExamAreaPicker({super.key, required this.onAreaSelect});

  @override
  Widget build(BuildContext context) {
    final selectedArea = useState<ExamArea>(ExamArea.LC);

    return Wrap(
      spacing: 10,
      children: [
        CheckButton(
          checked: selectedArea.value == ExamArea.LC,
          text: 'Linguagens',
          onCheck: () {
            onAreaSelect(ExamArea.LC);
            selectedArea.value = ExamArea.LC;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.CH,
          text: 'Ciências Humanas',
          onCheck: () {
            onAreaSelect(ExamArea.CH);
            selectedArea.value = ExamArea.CH;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.MT,
          text: 'Matemática',
          onCheck: () {
            onAreaSelect(ExamArea.MT);
            selectedArea.value = ExamArea.MT;
          },
        ),
        CheckButton(
          checked: selectedArea.value == ExamArea.CN,
          text: 'Ciências da Natureza',
          onCheck: () {
            onAreaSelect(ExamArea.CN);
            selectedArea.value = ExamArea.CN;
          },
        ),
      ],
    );
  }
}
