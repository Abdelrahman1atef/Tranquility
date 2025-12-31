import 'package:flutter/material.dart';
import 'package:tranquility/views/login.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_input_text.dart';
import '../core/widgets/app_text.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key,  this.editPassword=false});
  final bool editPassword;
  @override
  Widget build(BuildContext context) {
    final String title = editPassword ? "Change Your Password" : "Create New Password";
    final String oldPassword = editPassword ? "Old Password" : "";
    final String password = editPassword ? "New Password" : "Password";
    final String confirmPassword = editPassword ? "Confirm New Password" : "Confirm Password";
    final String buttonText = editPassword ? "Change Password" : "Confirm";
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
                    visible: !editPassword,
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
                      visible: editPassword,
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
