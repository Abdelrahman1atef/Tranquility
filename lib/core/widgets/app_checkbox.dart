import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  const AppCheckbox({super.key, required this.val});
  final bool val;

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool val =false;

  @override
  void initState() {
    val = widget.val;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: val,
      onChanged: (value) {
        setState(() {
          val = value!;
        });
      },
      fillColor: const WidgetStatePropertyAll(Colors.transparent),
      overlayColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.secondary,
      ),
      // activeColor: Theme.of(
      //   context,
      // ).colorScheme.secondaryContainer,
      checkColor: Theme.of(
        context,
      ).colorScheme.secondaryContainer,
      // focusColor:  Theme.of(
      //   context,
      // ).colorScheme.secondaryContainer,
    );
  }
}
