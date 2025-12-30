import 'package:flutter/material.dart';

import 'app_Image.dart';

class AppInputText extends StatefulWidget {
  const AppInputText({
    super.key,
    this.labelText,
    this.isPasswordField = false,
    this.controller,
    this.validator,
    this.hintText,
    this.title,
    this.haveTitle,
    this.padding,
    this.obscuringCharacter = '•',
    this.borderRadius,
    this.fillColor,
    this.borderWidth,
    this.textInputType, this.maxLines, this.borderColor,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final TextInputType? textInputType;
  final Color? fillColor,borderColor;
  final bool isPasswordField;
  final bool? haveTitle;
  final int? maxLines;
  final double? borderRadius,borderWidth;
  final String obscuringCharacter;
  final String? title,labelText,hintText;

  @override
  State<AppInputText> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<AppInputText> {
  bool passwordIsHidden = true;
  double borderWidth = 1;
  double borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.haveTitle ?? false) ...{
          Text(widget.title ?? "", style: TextTheme.of(context).titleSmall),
          const SizedBox(height: 10),
        },
        InputDecorationTheme(
          //todo review this
          // data:Theme.of(context).inputDecorationTheme,
          labelStyle: TextTheme.of(context).titleMedium,
          filled: true,
          fillColor: widget.fillColor ?? Theme.of(context).colorScheme.surface,
          floatingLabelStyle: TextTheme.of(
            context,
          ).titleMedium?.copyWith(fontSize: 25),
          hintMaxLines: 1,
          hintStyle: Theme.of(context).textTheme.labelLarge,
          contentPadding:
              widget.padding ??
              const EdgeInsetsGeometry.symmetric(vertical: 18, horizontal: 10),

          focusedBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? borderRadius,
            ),
            borderSide: BorderSide(
              color: widget.borderColor??Theme.of(context).colorScheme.outline,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? borderRadius,
            ),
            borderSide: BorderSide(
              color: widget.borderColor??Theme.of(context).colorScheme.outline,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),
          errorMaxLines: 2,
          errorStyle: TextTheme.of(context).displaySmall,
          errorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? borderRadius,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? borderRadius,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: widget.borderWidth ?? borderWidth,
            ),
          ),

          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            style: Theme.of(context).textTheme.displayMedium,
            obscureText: widget.isPasswordField ? passwordIsHidden : false,
            obscuringCharacter: widget.obscuringCharacter,
            keyboardType: widget.textInputType,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText ?? "",
              suffixIcon: widget.isPasswordField
                  ? passwordIsHidden
                        ? IconButton(
                            icon: const AppImage(image: "visibility_off.svg"),
                            onPressed: () {
                              setState(() {
                                passwordIsHidden = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: const AppImage(image: "visibility.svg"),
                            onPressed: () {
                              setState(() {
                                passwordIsHidden = true;
                              });
                            },
                          )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
