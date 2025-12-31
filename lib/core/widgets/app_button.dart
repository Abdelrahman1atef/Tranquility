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
    this.shape, this.text, this.margin,
  });

  final void Function() onPressed;
  final Widget? icon;
  final Color? color;
  final bool? isChildIcon;
  final double? borderRadius;
  final EdgeInsetsDirectional? margin,padding;
  final bool? isGradientColored;
  final OutlinedBorder? shape;
  final String? text;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: isChildIcon?? false?60:null,
      width: isChildIcon?? false?60:null,
      margin: margin?? const EdgeInsetsDirectional.all(0),
      decoration:
           BoxDecoration(
        color: isGradientColored ?? false
            ? Colors.transparent
            : color ?? ColorScheme.of(context).primaryContainer,
              borderRadius: BorderRadiusGeometry.circular(borderRadius ?? 8),
           gradient:isGradientColored ?? false? LinearGradient(
                colors: [
                  ColorScheme.of(context).secondaryContainer,
                  ColorScheme.of(context).primaryContainer,
                ],
              ): null,
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:const WidgetStatePropertyAll(Colors.transparent) ,
          padding: WidgetStatePropertyAll(padding??const EdgeInsetsDirectional.all(0)),
          elevation: const WidgetStatePropertyAll(0),
          alignment: AlignmentGeometry.center,
          shape: WidgetStatePropertyAll(
            isChildIcon ?? false
                ? RoundedSuperellipseBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  )
                : shape??RoundedSuperellipseBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
        ),
        child:isChildIcon??false?icon:AppText(text??"",style: Theme.of(context).textTheme.bodyMedium,),
      ),
    );
  }
}
