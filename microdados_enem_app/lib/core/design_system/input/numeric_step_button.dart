import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:microdados_enem_app/core/design_system/button/app_icon_button.dart';
import 'package:microdados_enem_app/core/design_system/input/text_input.dart';

class NumericStepButton extends HookWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;

  final ValueChanged<int> onChanged;

  const NumericStepButton({
    super.key,
    required this.minValue,
    required this.maxValue,
    this.initialValue = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialValue.toString());
    final textValue = useValueListenable(controller);

    void handleValueChange(int newValue) {
      final clampedValue = newValue.clamp(minValue, maxValue);
      controller.text = clampedValue.toString();
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      onChanged(clampedValue);
    }

    final currentValue = int.tryParse(textValue.text) ?? initialValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextInput(
            controller: controller,
            inputType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                final newValue = int.tryParse(value);
                if (newValue != null) handleValueChange(newValue);
              }
            },
          ),
        ),
        SizedBox(width: 10),
        AppIconButton(
          icon: Icons.remove,
          onTap:
              currentValue == minValue
                  ? null
                  : () => handleValueChange(currentValue - 1),
        ),
        SizedBox(width: 2),
        AppIconButton(
          icon: Icons.add,
          onTap:
              currentValue == maxValue
                  ? null
                  : () => handleValueChange(currentValue + 1),
        ),
      ],
    );
  }
}
