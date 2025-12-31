import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/login.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    animationController.forward();
    Future.delayed(const Duration(milliseconds: 2000), () =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginView(),)),);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: animationController.view,
            child: child,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(50),
          child: Container(
            margin: const EdgeInsetsGeometry.all(35),
            alignment: AlignmentGeometry.center,
            decoration: BoxDecoration(
              color: Theme
                  .of(
                context,
              )
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  "Tranquility",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,
                ),
                AppText(
                  "Together Towards Tranquility",
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
