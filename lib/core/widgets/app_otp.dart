import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppOtp extends StatelessWidget {
  const AppOtp({
    super.key,
    required this.length,
    this.textInputType,
    this.fieldWidth = 70,
    this.fieldHeight = 70,
    this.enableHint,
  });

  final int length;
  final TextInputType? textInputType;
  final double? fieldWidth;
  final double? fieldHeight;
  final bool? enableHint;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      keyboardType: textInputType ?? TextInputType.number,
      textStyle: TextTheme.of(
        context,
      ).displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
      animationType: AnimationType.fade,
      hintCharacter: enableHint ?? true ? "_" : null,
      hintStyle: enableHint ?? true
          ? Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 25,
              fontVariations: <FontVariation>[const FontVariation('wght', 700)],
            )
          : null,
      enableActiveFill: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      cursorColor: Theme.of(context).hintColor,
      cursorWidth: 3,
      pinTheme: PinTheme(
        fieldWidth: fieldWidth,
        fieldHeight: fieldHeight,
        borderRadius: BorderRadius.circular(8),
        shape: PinCodeFieldShape.box,
        selectedFillColor:Theme.of(context).colorScheme.surface,
        activeFillColor: Theme.of(context).colorScheme.surface,
        inactiveFillColor: Theme.of(context).colorScheme.surface,
        inactiveColor: Theme.of(context).colorScheme.outline,
        selectedColor: Theme.of(context).colorScheme.outline,
        activeColor: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
