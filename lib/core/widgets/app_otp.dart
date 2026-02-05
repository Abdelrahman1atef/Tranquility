import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppOtp extends StatefulWidget {
  const AppOtp({
    super.key,
    required this.length,
    this.textInputType,
    this.fieldWidth = 70,
    this.fieldHeight = 70,
    this.enableHint, this.controller,
  });
  final int length;
  final TextInputType? textInputType;
  final double? fieldWidth;
  final double? fieldHeight;
  final bool? enableHint;
  final TextEditingController? controller;

  @override
  State<AppOtp> createState() => _AppOtpState();
}

class _AppOtpState extends State<AppOtp> {

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty){
          return "Please enter the code";
        }
        if (value.length != widget.length){
          return "Please enter the correct code";
        }
        return null;
      },
      appContext: context,
      length: widget.length,
      keyboardType: widget.textInputType ?? TextInputType.number,
      textStyle: TextTheme.of(
        context,
      ).displayMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
      animationType: AnimationType.fade,
      hintCharacter: widget.enableHint ?? true ? "_" : null,
      hintStyle: widget.enableHint ?? true
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
        fieldWidth: widget.fieldWidth,
        fieldHeight: widget.fieldHeight,
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
