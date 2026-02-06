import 'package:flutter/material.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.isChildIcon = false,
    this.borderRadius,
    this.padding,
    this.isGradientColored = false,
    this.shape,
    this.text = "",
    this.margin,
    this.widget,
    this.textStyle,
    this.height,
    this.width,
  });

  final VoidCallback? onPressed;
  final Widget? icon, widget;
  final Color? color;
  final EdgeInsetsDirectional? margin, padding;
  final OutlinedBorder? shape;
  final TextStyle? textStyle;
  final bool isChildIcon, isGradientColored;
  final String text;
  final double? borderRadius, height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsetsDirectional.all(0),
      decoration: BoxDecoration(
        color: isGradientColored ? Colors.transparent : color ?? ColorScheme.of(context).primaryContainer,
        borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 8),
        gradient: isGradientColored
            ? LinearGradient(
                colors: [ColorScheme.of(context).secondaryContainer, ColorScheme.of(context).primaryContainer],
              )
            : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          padding: WidgetStatePropertyAll(padding ?? const EdgeInsetsDirectional.symmetric(vertical: 19)),
          elevation: const WidgetStatePropertyAll(0),
          shape: shape != null
              ? WidgetStatePropertyAll(shape)
              : WidgetStatePropertyAll(
                  RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 8)),
                ),
          alignment: AlignmentGeometry.center,
        ),
        child: text.isNotEmpty
            ? AppText(text, style: Theme.of(context).textTheme.bodyMedium?.merge(textStyle))
            : widget,
      ),
    );
  }
}
