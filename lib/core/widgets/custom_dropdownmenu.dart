import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_text.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    super.key,
    this.onChanged,
    required this.hintText,
    this.borderRadius, this.icon,  this.borderWidth, this.value, required this.items,
  });

  final ValueChanged<String?>? onChanged;
  final String hintText;
  final double? borderRadius;
  final Widget? icon;
  final double? borderWidth;
  final String? value;
  final List<DropdownMenuItem<String>> items ;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  double borderWidth=1;
  double borderRadius=8;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? borderRadius),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: widget.borderWidth??borderWidth,
        ),
      ),
      child: DropdownButton(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 3),
        elevation: 0,
        isExpanded: true,
        icon:widget.icon?? const Icon(Icons.keyboard_arrow_down_rounded),
        style: TextTheme.of(context).displayMedium,
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        underline: const SizedBox(),
        hint: AppText(widget.hintText, style: Theme.of(context).textTheme.labelLarge),
        disabledHint: AppText(widget.hintText, style: Theme.of(context).textTheme.labelLarge),
        onChanged: widget.onChanged,
         value: widget.value,
        items: widget.items,
      ),
    );
  }
}
