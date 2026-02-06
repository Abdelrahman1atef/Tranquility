import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/cash_helper.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/login/view.dart';
import 'package:tranquility/views/onboarding.dart';

import '../core/logic/helper_methods.dart';
import 'home/view.dart';
import 'login/model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animationController.forward();
    final isFirstTime = CashHelper.getFirstTime() ?? true;
    final response = await DioHelper.getData("api/Profile");
    if (response.isSuccess) {
      final data = Data.fromJson(response.data);
      //todo update this
      await CashHelper.setUserDate(data);
      Future.delayed(
        const Duration(milliseconds: 2000),
        () => goto(isFirstTime ? const OnboardingView() : const HomeView()),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 2000),
        () => goto(isFirstTime ? const OnboardingView() : const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(opacity: animationController.view, child: child);
        },
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(50),
          child: Container(
            margin: const EdgeInsetsGeometry.all(35),
            alignment: AlignmentGeometry.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText("Tranquility", style: Theme.of(context).textTheme.headlineLarge),
                AppText("Together Towards Tranquility", style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
