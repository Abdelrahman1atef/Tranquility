import 'package:flutter/material.dart';
import 'package:tranquility/views/login/view.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_input_text.dart';
import '../core/widgets/app_text.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key,  this.changePassword=false});
  final bool changePassword;
  @override
  Widget build(BuildContext context) {
    final String title = changePassword ? "Change Your Password" : "Create New Password";
    final String oldPassword = changePassword ? "Old Password" : "";
    final String password = changePassword ? "New Password" : "Password";
    final String confirmPassword = changePassword ? "Confirm New Password" : "Confirm Password";
    final String buttonText = changePassword ? "Change Password" : "Confirm";
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(haveTitle: false, haveSearchBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppImage(image: "forget_password.png"),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Visibility(
                    visible: !changePassword,
                    child: AppText(
                      "create your new password to log in !",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                         fontSize: 18,
                        fontVariations: [
                          const FontVariation('wght', 500),
                        ]
                          ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  Visibility(
                      visible: changePassword,
                      child: AppInputText(hintText: oldPassword,isPasswordField: true,)),
                  const SizedBox(height: 16),
                   AppInputText(hintText: password,isPasswordField: true,),
                  const SizedBox(height: 16),
                   AppInputText(hintText: confirmPassword,isPasswordField: true,),
                  const SizedBox(height: 33),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginView()),
                          ),
                          padding:const EdgeInsetsDirectional.symmetric(vertical: 20),
                          text: buttonText,
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
