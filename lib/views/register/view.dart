import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/helper_methods.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_add_image.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/login/view.dart';
import 'package:tranquility/views/otp.dart';

import '../../core/widgets/app_Image.dart';
import '../../core/widgets/app_drop_menu.dart';
import 'model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedImage = "";
  String _selectedGender = "Male";
  DataStates _state = DataStates.uninitialized;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register(RegisterRequest data) async {
    _state = DataStates.loading;
    setState(() {});
    final response = await DioHelper.postData(endpoint: "api/Auth/register", data: data.toFormData());
    if (response.isSuccess) {
      showMsg(response.msg);
      goto(OtpView(isForgetPassword: false, email: _emailController.text));
      _state = DataStates.loaded;
    } else {
      showMsg(response.msg, isError: true);
      _state = DataStates.error;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.only(top: kToolbarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              AppAddImage(onChange: (value) => _selectedImage = value),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsetsGeometry.only(left: 24, right: 24, bottom: 50),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username is required";
                              }
                              if (value.length < 3) {
                                return "Username must be at least 3 characters";
                              }
                              if (value.length > 20) {
                                return "Username must be less than 20 characters";
                              }
                              if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                                return "Username must contain only letters and numbers";
                              }
                              return null;
                            },
                          ),
                          AppInputText(
                            controller: _emailController,
                            hintText: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              if (!validateEmail(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                          AppInputText(
                            controller: _ageController,
                            hintText: "Age",
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Age is required";
                              }

                              final age = int.tryParse(value);

                              if (age == null) {
                                return "Enter valid number";
                              }

                              if (age < 1 || age > 120) {
                                return "Enter valid age";
                              }

                              return null;
                            },
                          ),
                          AppDropMenu(
                            hintText: "Gender",
                            icon: const AppImage(image: "arrow_down.svg"),
                            value: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(value: "Male", child: Text('Male')),
                              DropdownMenuItem(value: "Female", child: Text('Female')),
                            ],
                          ),

                          AppInputText(
                            controller: _passwordController,
                            hintText: "Password",
                            maxLines: 1,
                            isPasswordField: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                          ),
                          AppInputText(
                            controller: _confirmPasswordController,
                            hintText: "Confirm password",
                            maxLines: 1,
                            isPasswordField: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password is required";
                              }
                              if (value != _passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
                            shape: RoundedSuperellipseBorder(borderRadius: BorderRadiusGeometry.circular(8)),
                            onPressed: () async {
                              if (_selectedImage == "" || _selectedImage.isEmpty) {
                                showMsg("Please Select Image", isError: true);
                              }
                              if (!_formKey.currentState!.validate()) return;
                              final data = RegisterRequest(
                                name: _usernameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                confirmPassword: _confirmPasswordController.text,
                                age: _ageController.text,
                                gender: _selectedGender,
                              );
                              await _register(data);
                            },
                            text: "Sign Up",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => goto(const LoginView()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            "Already have an account ? ",
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
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
