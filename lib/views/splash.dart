import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  //todo handle splash screen to make auto nav to first screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(50),
        child: Container(
          margin: const EdgeInsetsGeometry.all(35),
          alignment: AlignmentGeometry.center,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                "Tranquility",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              AppText(
                "Together Towards Tranquility",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
