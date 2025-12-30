import 'package:flutter/material.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
    this.isChildIcon,
    this.borderRadius,
    this.padding,
    this.isGradientColored,
    this.shape, this.text,
  });

  final void Function() onPressed;
  final Widget? icon;
  final Color? color;
  final bool? isChildIcon;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool? isGradientColored;
  final OutlinedBorder? shape;
  final String? text;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isGradientColored ?? false
          ? BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 0),
              gradient: LinearGradient(
                colors: [
                  ColorScheme.of(context).secondaryContainer,
                  ColorScheme.of(context).primaryContainer,
                ],
              ),
            )
          : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          alignment: AlignmentGeometry.center,
          padding: WidgetStatePropertyAll(padding??EdgeInsetsGeometry.symmetric(vertical: 16)),
          shape: WidgetStatePropertyAll(
            isChildIcon ?? false
                ? RoundedSuperellipseBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  )
                : shape??RoundedSuperellipseBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          backgroundColor: isGradientColored ?? false
              ? const WidgetStatePropertyAll(Colors.transparent)
              : WidgetStatePropertyAll(
                  color ?? ColorScheme.of(context).primaryContainer,
                ),
        ),
        child:isChildIcon??false?icon:AppText(text??"",style: Theme.of(context).textTheme.bodyMedium,),
      ),
    );
  }
}
