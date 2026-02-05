import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/cash_helper.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/home/view.dart';
import 'package:tranquility/views/login/view.dart';

import '../core/logic/helper_methods.dart';
import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';
import '../core/widgets/app_otp.dart';
import 'change_password.dart';
import 'login/model.dart';

class OtpModel {
  final String email;
  final String otp;
  final String deviceToken;
  final String deviceType;

  OtpModel({required this.email, required this.otp, required this.deviceToken, required this.deviceType});

  FormData toFormData() {
    final formData = FormData();
    formData.fields.add(MapEntry("Email", email));
    formData.fields.add(MapEntry("Otp", otp));
    formData.fields.add(MapEntry("DeviceToken", deviceToken));
    formData.fields.add(MapEntry("DeviceType", deviceType));
    return formData;
  }
}

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.isForgetPassword, required this.email});

  final bool isForgetPassword;
  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final _key = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  DataStates _state = DataStates.uninitialized;

  Future<void> _otpValidation(OtpModel data) async {
    _state = DataStates.loading;
    setState(() {});
    if (widget.isForgetPassword) {
      goto(const ChangePasswordView(changePassword: true));
      showMsg("OTP Verified Successfully");
      _state = DataStates.loaded;
    }else{
      final response = await DioHelper.postData(endpoint: "api/Auth/verify-otp", data: data.toFormData());
      if (response.isSuccess) {
        final loginResponse = LoginResponse.fromJson(response.data);
        CashHelper.setUserDate(loginResponse);
        showMsg(response.msg);
        goto(const HomeView());
        _state = DataStates.loaded;
      } else {
        showMsg(response.msg, isError: true);
        _state = DataStates.error;
      }
    }

    setState(() {});
  }

  Future<void> _resendOtpValidation(String email) async {
    _state = DataStates.loading;
    setState(() {});
    final email = FormData();
    email.fields.add(MapEntry("Email", widget.email));
    final response = await DioHelper.postData(endpoint: "api/Auth/resend-otp", data: email);
    if (response.isSuccess) {
      showMsg(response.msg);
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
            const AppImage(image: "otp.png"),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("Verification", style: Theme.of(context).textTheme.titleMedium),
                  AppText(
                    "Please enter the code sent on your phone.",
                    style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor.withValues(alpha: 0.8)),
                  ),

                  const SizedBox(height: 36),
                  Form(
                    key: _key,
                    child: AppOtp(controller: _otpController, length: 4, fieldWidth: 90, enableHint: false),
                  ),
                  const SizedBox(height: 9),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 18, color: Color(0xFF434C6D)),
                      children: [
                        const TextSpan(text: "Didn’t receive a code? "),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () => _resendOtpValidation(widget.email),
                            child: const Text(
                              "Resend",
                              style: TextStyle(fontSize: 18, color: Color(0xFF284243), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 29),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () {
                            if (!_key.currentState!.validate()) return;
                            final data = OtpModel(
                              email: widget.email,
                              otp: _otpController.text,
                              deviceToken: CashHelper.getFcmToken(),
                              deviceType: getPlatform(),
                            );
                            _otpValidation(data);
                            goto(widget.isForgetPassword ? const ChangePasswordView() : const LoginView());
                          },
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
