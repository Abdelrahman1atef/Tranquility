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
    this.obscuringCharacter = '•', this.borderRadius, this.fillColor,
  });

  final TextEditingController? controller;
  final bool isPasswordField;
  final String? title;
  final bool? haveTitle;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final String obscuringCharacter ;
  final double? borderRadius ;
  final Color? fillColor ;

  @override
  State<AppInputText> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<AppInputText> {
  bool passwordIsHidden = true;

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

          fillColor: widget.fillColor,
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
            borderRadius: BorderRadius.circular(widget.borderRadius ??8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ??8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          errorMaxLines: 2,
          errorStyle: TextTheme.of(context).displaySmall,
          errorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ??8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 16,
            borderRadius: BorderRadius.circular(widget.borderRadius ??8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),

          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            style: Theme.of(context).textTheme.displayMedium,
            obscureText: widget.isPasswordField ? passwordIsHidden : false,
            obscuringCharacter: widget.obscuringCharacter,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText ?? "",
              suffixIcon: widget.isPasswordField
                  ? passwordIsHidden
                        ? IconButton(
                            icon: AppImage(image: "visibility_off.svg"),
                            onPressed: () {
                              setState(() {
                                passwordIsHidden = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: AppImage(image: "visibility.svg"),
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
