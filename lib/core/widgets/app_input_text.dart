import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_Image.dart';

class AppInputText extends StatefulWidget {
  const AppInputText({
    super.key,
    this.labelText ,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.hintText = "",
    this.title = "",
    this.padding,
    this.obscuringCharacter = '•',
    this.borderRadius,
    this.fillColor,
    this.borderWidth,
    this.textInputType,
    this.maxLines = 1,
    this.borderColor,  this.enabled = true,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final TextInputType? textInputType;
  final Color? fillColor, borderColor;
  final bool isPasswordField, enabled;
  final int maxLines;
  final double? borderRadius, borderWidth;
  final String obscuringCharacter;
  final String? labelText;
  final String title, hintText;

  @override
  State<AppInputText> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<AppInputText> {
  bool passwordIsHidden = true;
  double borderWidth = 1;
  double borderRadius = 8;

  OutlineInputBorder _border([bool isError = false]) => OutlineInputBorder(
    gapPadding: 16,
    borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
    borderSide: BorderSide(
      color: isError
          ? Theme.of(context).colorScheme.error
          : widget.borderColor ?? Theme.of(context).colorScheme.outline,
      width: widget.borderWidth ?? borderWidth,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(widget.title, style: TextTheme.of(context).titleSmall),
          ),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          style: Theme.of(context).textTheme.displayMedium,
          obscureText: widget.isPasswordField ? passwordIsHidden : false,
          obscuringCharacter: widget.obscuringCharacter,
          keyboardType: widget.textInputType,
          enabled: widget.enabled,
          inputFormatters: [
            if (widget.textInputType == TextInputType.number) ...[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.length > 2) {
                  return oldValue;
                }
                return newValue;
              },)
            ]
          ],
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextTheme.of(context).titleMedium,
            filled: true,
            fillColor: widget.fillColor ?? Theme.of(context).colorScheme.surface,
            floatingLabelStyle: TextTheme.of(context).titleMedium?.copyWith(fontSize: 25),
            hintMaxLines: 1,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.labelLarge,
            contentPadding: widget.padding ?? const EdgeInsetsGeometry.symmetric(vertical: 18, horizontal: 10),
            focusedBorder: _border(),
            enabledBorder: _border(),
            disabledBorder: _border(),
            errorMaxLines: 2,
            errorStyle: TextTheme.of(
              context,
            ).displayMedium?.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 16),
            errorBorder: _border(true),
            focusedErrorBorder: _border(true),
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    icon: AppImage(image: "visibility${passwordIsHidden ? "_off" : ""}.svg"),
                    onPressed: () {
                      passwordIsHidden = !passwordIsHidden;

                      setState(() {});
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
