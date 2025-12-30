import 'package:flutter/material.dart';
import 'package:tranquility/views/login.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_input_text.dart';
import '../core/widgets/app_text.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

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
                    "Create New Password",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppText(
                    "create your new password to log in !",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                       fontSize: 18,
                      fontVariations: [
                        const FontVariation('wght', 500),
                      ]
                        ),
                  ),
                  SizedBox(height: 33),
                  AppInputText(hintText: "Password",isPasswordField: true,),
                  SizedBox(height: 16),
                  AppInputText(hintText: "Confirm Password",isPasswordField: true,),
                  SizedBox(height: 33),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginView()),
                          ),
                          text: "Confirm",
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
