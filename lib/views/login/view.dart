import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/helper_methods.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/views/forget_password.dart';
import 'package:tranquility/views/home/view.dart';
import 'package:tranquility/views/login/model.dart';
import 'package:tranquility/views/register/view.dart';

import '../../core/logic/cash_helper.dart';
import '../../core/widgets/app_Image.dart';
import '../../core/widgets/app_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "man1207468@gmail.com");
  final _passwordController = TextEditingController(text: "12345678");
  var _state = DataStates.uninitialized;

  Future<void> _login({required LoginRequest data}) async {
    _state = DataStates.loading;
    setState(() {});
    final response = await DioHelper.postData(endpoint: "api/Auth/login", data: data.toFormData());
    if (response.isSuccess) {
      _state = DataStates.loaded;
      final loginResponse = LoginResponse.fromJson(response.data);
      await CashHelper.setUserDate(loginResponse.data);
      await CashHelper.setToken(loginResponse.data.token);
      goto(const HomeView(),canPop: false);
    } else {
      _state = DataStates.error;
      showMsg(response.msg, isError: true);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:


      SingleChildScrollView(
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
                    AppText("Welcome To", style: Theme.of(context).textTheme.displayMedium),
                    const SizedBox(height: 6),
                    AppText("Tranquility", style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 6),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          AppInputText(
                            controller: _emailController,
                            hintText: "Email",
                            fillColor: Theme.of(context).colorScheme.surface,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              if (!validateEmail(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppInputText(
                            controller: _passwordController,
                            hintText: "Password",
                            isPasswordField: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => goto(const ForgetPasswordView()),
                          child: AppText("Forgot Password?", style: Theme.of(context).textTheme.headlineMedium),
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
                          width: 70,
                          height: 70,
                          color: Theme.of(context).colorScheme.surface,
                          widget: const AppImage(image: "finger_print.svg"),
                        ),

                        Expanded(
                          child: AppButton(
                            onPressed: _state == DataStates.loading
                                ? null
                                : () async {
                                    if (!_key.currentState!.validate()) return;
                                    final data = LoginRequest(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                      deviceToken: CashHelper.getFcmToken(),
                                      deviceType: getPlatform(),
                                    );
                                    _login(data: data);
                                  },
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                            shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
                            borderRadius: 10,
                            widget: _state == DataStates.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    constraints: BoxConstraints(minWidth: 30, minHeight: 30),
                                  )
                                : AppText("Log In", style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => goto(const RegisterView()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            "Don’t have an account ? ",
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
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
                          onTap: () {},
                        ),
                        _SocialLoginWidget(
                          color: const Color(0xFF518EF8).withValues(alpha: 0.5),
                          imageString: "facebook.svg",
                          text: "Login With Facebook",
                          onTap: () {},
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
  const _SocialLoginWidget({required this.color, required this.imageString, required this.text, required this.onTap});

  final Color color;
  final String imageString;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(color),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadiusGeometry.circular(8)),
        child: Row(
          spacing: 8,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
              padding: const EdgeInsetsGeometry.all(13),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                color: Colors.white,
                border: Border(
                  left: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: 0.3), width: 3),
                ),
              ),
              child: AppImage(image: imageString, width: 30, fit: BoxFit.cover),
            ),
            AppText(text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
