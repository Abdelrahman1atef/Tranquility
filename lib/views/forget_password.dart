import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/views/otp.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_text.dart';
import 'change_password.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(haveTitle: false, haveSearchBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image: "forget_password.png"),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "Forget Your Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 33),
                  AppInputText(hintText: "Phone Number"),
                  SizedBox(height: 33),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OtpView(isForgetPassword: true,)),
                          ),
                          text: "Forget Password",
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
