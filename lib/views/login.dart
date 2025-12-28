import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsetsGeometry.only(top: kToolbarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image: "login.png"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Welcome To",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 6),
                  AppText(
                    "Tranquility",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 6),
                  AppInputText(
                    hintText: "Phone Number",
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(height: 16),
                  AppInputText(
                    hintText: "Password",
                    isPasswordField: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: AppText(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                      SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      AppButton(
                        onPressed: () {},
                        isChildIcon: true,
                        padding: EdgeInsetsGeometry.symmetric(vertical: 18),
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                        child: AppImage(image: "finger_print.svg"),
                      ),

                      Expanded(
                        child: AppButton(
                          onPressed: () {},
                          padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                          borderRadius: 10,
                          child: AppText("Log In", style: Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
