import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_add_image.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/login.dart';
import 'package:tranquility/views/otp.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsGeometry.only(top: kToolbarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const AppAddImage(),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsetsGeometry.only(left: 24, right: 24,bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          spacing: 16,
                          children: [
                            AppInputText(
                              controller: _usernameController,
                              hintText: "Username",
                            ),
                            AppInputText(
                              controller: _phoneNumberController,
                              hintText: "Phone Number",
                              textInputType: TextInputType.phone,
                            ),
                            AppInputText(
                              controller: _ageController,
                              hintText: "Age",
                              textInputType: TextInputType.number,
                            ),

                            AppInputText(
                              controller: _passwordController,
                              hintText: "Password",
                              maxLines: 1,
                              isPasswordField: true,
                            ),
                            AppInputText(
                              controller: _confirmPasswordController,
                              hintText: "Confirm password",
                              maxLines: 1,
                              isPasswordField: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 16),
                              shape: RoundedSuperellipseBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                              //todo add validation for nav
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OtpView(isForgetPassword: false),
                                  ),
                                );
                              },
                              text: "Sign Up",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              "Already have an account ? ",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                              ),
                            ),
                            const AppText("Login"),
                          ],
                        ),
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
