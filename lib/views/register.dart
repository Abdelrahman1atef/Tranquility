import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/login.dart';
import 'package:tranquility/views/otp.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/custom_dropdownmenu.dart';

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

  String imageSelected = "";

  Future<void> _openCamera() async {
    var picker = ImagePicker();
    var cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        setState(() {
          imageSelected = photo.path;
        });
      }
    } else if (cameraStatus.isDenied) {
      openAppSettings();
    } else if (cameraStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    else {
      print("Something went wrong");
    }
  }

  Future<void> _openGallery() async {
    final picker = ImagePicker();
    var photosStatus = await Permission.photos.request();
    var storageStatus = await Permission.storage.request();
    if (photosStatus.isGranted || storageStatus.isGranted) {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        setState(() {
          imageSelected = photo.path;
        });
      }
    } else if (photosStatus.isDenied || storageStatus.isDenied) {
      openAppSettings();
    } else
    if (photosStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    else {
      print("Something went wrong");
    }
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
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          Container(
                            height: 250,
                            padding: const EdgeInsetsGeometry.symmetric(
                              vertical: 50,
                              horizontal: 24,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(2, 5),
                                topRight: Radius.circular(18),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  "Pick Image From...",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 72,
                                  children: [
                                    InkWell(
                                      onTap: () => _openCamera(),
                                      child: const AppImage(image: "camera.svg"),
                                    ),
                                    InkWell(
                                      onTap: () =>_openGallery(),
                                      child: const AppImage(image: "gallary.svg"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                  child: Stack(
                    children: [
                      imageSelected == ""
                          ? const AppImage(image: "pick_image.svg")
                          : ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        child: AppImage(
                          image: imageSelected,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          padding: const EdgeInsetsGeometry.all(10),
                          child: imageSelected == ""
                              ? const AppImage(image: "add.svg") : const AppImage(
                              image: "edit.svg"),
                        ),
                      ),

                      if(imageSelected != "")
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme
                                .of(context)
                                .primaryColor
                                .withValues(alpha: 0.25),
                          ),
                          padding: const EdgeInsetsGeometry.all(10),
                          child:
                          InkWell(
                              onTap: () =>
                                  setState(() {
                                    imageSelected = "";
                                  }),
                              child: const AppImage(image: "delete_chat.svg")),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
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
                            CustomDropdownMenu(
                              hintText: "Gender",
                              icon: const AppImage(image: "arrow_down.svg"),
                              onChanged: (value) {
                                print(value);
                              },
                              items: const [
                                DropdownMenuItem(
                                    value: "M", child: Text('Male')),
                                DropdownMenuItem(
                                  value: "F",
                                  child: Text('Female'),
                                ),
                              ],
                            ),
                            AppInputText(
                              controller: _passwordController,
                              hintText: "Password",
                              isPasswordField: true,
                            ),
                            AppInputText(
                              controller: _confirmPasswordController,
                              hintText: "Confirm password",
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
                              padding: const EdgeInsetsGeometry.symmetric(
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
