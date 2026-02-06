import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/views/otp.dart';

import '../core/logic/helper_methods.dart';
import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_text.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "");
  DataStates _state = DataStates.uninitialized;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _forgetPassword() async {
    _state = DataStates.loading;
    setState(() {});
    final formData = FormData();
    formData.fields.add(MapEntry("email", _emailController.text));
    final response = await DioHelper.postData(endpoint: "api/Auth/forgot-password", data: formData);
    if (response.isSuccess) {
      showMsg(response.msg);
      goto(OtpView(isForgetPassword: true,email: _emailController.text,));
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
      appBar: const CustomAppBar(haveTitle: false, haveSearchBar: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppImage(image: "forget_password.png"),
            SingleChildScrollView(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Forget Your Password", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 33),
                  Form(
                    key: _key,
                    child: AppInputText(
                      controller: _emailController,
                      hintText: "Email",
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
                  ),
                  const SizedBox(height: 33),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: _state == DataStates.loading
                              ?null: () async {
                            if (!_key.currentState!.validate()) return;
                            await _forgetPassword();
                          },
                          widget: _state == DataStates.loading
                              ? const CircularProgressIndicator(color: Colors.white,
                            constraints: BoxConstraints(minWidth: 30, minHeight: 30),)
                              : AppText( "Forget Password",style: Theme.of(context).textTheme.bodyMedium),
                          padding: const EdgeInsetsDirectional.symmetric(vertical: 19),
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
