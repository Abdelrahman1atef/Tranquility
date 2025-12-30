import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/forget_password.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_otp.dart';
import 'change_password.dart';
import 'home/view.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key, required this.isForgetPassword});

  final bool isForgetPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(haveTitle: false, haveSearchBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image: "otp.png"),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Verification",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppText(
                    "Please enter the code sent on your phone.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 36),
                  AppOtp(length: 4, fieldWidth: 90, enableHint: false),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => isForgetPassword
                                  ? ChangePasswordView()
                                  : MainView(),
                            ),
                          ),
                          text: "Verify",
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
