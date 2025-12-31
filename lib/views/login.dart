import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/views/forget_password.dart';
import 'package:tranquility/views/home/view/view.dart';
import 'package:tranquility/views/register.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.only(top: kToolbarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppImage(image: "login.png"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Welcome To",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 6),
                    AppText(
                      "Tranquility",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 6),
                    AppInputText(
                      hintText: "Phone Number",
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(height: 16),
                    AppInputText(
                      hintText: "Password",
                      isPasswordField: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPasswordView(),
                            ),
                          ),
                          child: AppText(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        AppButton(
                          onPressed: () {},
                          isChildIcon: true,
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                          icon: const AppImage(image: "finger_print.svg"),
                        ),

                        Expanded(
                          child: AppButton(
                            //todo add validation for nav to home view
                            onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainView(),
                              ),
                              (route) => false,
                            ),
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                            borderRadius: 10,
                            text: "Log In",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterView()),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            "Don’t have an account ? ",
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const AppText("Sign up"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Column(
                      spacing: 16,
                      children: [
                        _SocialLoginWidget(
                          color: const Color(0xFF35B542).withValues(alpha: 0.5),
                          imageString: "google.svg",
                          text: "Login With Google",
                        ),
                        _SocialLoginWidget(
                          color: const Color(0xFF518EF8).withValues(alpha: 0.5),
                          imageString: "facebook.svg",
                          text: "Login With Facebook",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLoginWidget extends StatelessWidget {
  const _SocialLoginWidget({
    required this.color,
    required this.imageString,
    required this.text,
  });

  final Color color;
  final String imageString;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
            padding: const EdgeInsetsGeometry.all(13),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  width: 3,
                ),
              ),
            ),
            child: AppImage(image: imageString, width: 30, fit: BoxFit.cover),
          ),
          AppText(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
