import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/helper_methods.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/views/login/view.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_button.dart';
import '../core/widgets/app_input_text.dart';
import '../core/widgets/app_text.dart';

class _ChangePassword {
  final String? oldPassword;
  final String password;
  final String confirmPassword;

  _ChangePassword({this.oldPassword, required this.password, required this.confirmPassword});

  FormData toFormData() {
    final formData = FormData();
    if (oldPassword != null) formData.fields.add(MapEntry("OldPassword", oldPassword!));
    formData.fields.add(MapEntry("NewPassword", password));
    formData.fields.add(MapEntry("ConfirmNewPassword", confirmPassword));
    return formData;
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key, this.changePassword = false});

  final bool changePassword;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  String get title => widget.changePassword ? "Change Your Password" : "Create New Password";

  String get oldPassword => widget.changePassword ? "Old Password" : "";

  String get password => widget.changePassword ? "New Password" : "Password";

  String get confirmPassword => widget.changePassword ? "Confirm New Password" : "Confirm Password";

  String get buttonText => widget.changePassword ? "Change Password" : "Confirm";
  final _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  DataStates _state = DataStates.uninitialized;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword<T>({required _ChangePassword data}) async {
    _state = DataStates.loading;
    setState(() {});
    final CustomResponse<T> response;
    if (widget.changePassword) {
      response = await DioHelper.postData(endpoint: "api/Auth/change-password", data: data.toFormData());
    } else {
      response = await DioHelper.postData(endpoint: "api/Auth/reset-password", data: data.toFormData());
    }
    if (response.isSuccess) {
      _state = DataStates.loaded;
      showMsg(response.msg);
      goto(const LoginView(), canPop: false);
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
      appBar: const CustomAppBar(haveTitle: false, haveSearchBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppImage(image: "forget_password.png"),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(title, style: Theme.of(context).textTheme.titleMedium),
                    Visibility(
                      visible: !widget.changePassword,
                      child: AppText(
                        "create your new password to log in !",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontVariations: [const FontVariation('wght', 500)],
                        ),
                      ),
                    ),
                    const SizedBox(height: 33),
                    Visibility(
                      visible: widget.changePassword,
                      child: AppInputText(
                        controller: _oldPasswordController,
                        hintText: oldPassword,
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your old password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppInputText(
                      controller: _passwordController,
                      hintText: password,
                      isPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your old password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputText(
                      controller: _confirmPasswordController,
                      hintText: confirmPassword,
                      isPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your old password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 33),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onPressed: _state == DataStates.loading
                                ?null: () async {
                              if (!_key.currentState!.validate()) return;
                              final data = _ChangePassword(
                                oldPassword: _oldPasswordController.text.trim(),
                                password: _passwordController.text.trim(),
                                confirmPassword: _confirmPasswordController.text.trim(),
                              );
                              await _changePassword(data: data);
                            },
                            padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                            widget: _state == DataStates.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    constraints: BoxConstraints(minWidth: 30, minHeight: 30),
                                  )
                                : AppText(buttonText, style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
