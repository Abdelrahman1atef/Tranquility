import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_add_image.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';

import '../../../core/widgets/app_Image.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/custom_dropdownmenu.dart';
import '../../change_password.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _ageController = TextEditingController();
  String selectedImage = "";
  String selectedGender = "";

  @override
  void initState() {
    _usernameController.text = "Sara";
    _phoneNumberController.text = "01022322742";
    _ageController.text = "22";
    selectedImage = "profile.png";
    selectedGender = "F";
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.primary;
    final blendMode = BlendMode.srcIn;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          AppAddImage(imagePath: selectedImage),
          const SizedBox(height: 40),
          AppInputText(controller: _usernameController),
          const SizedBox(height: 16),
          AppInputText(controller: _phoneNumberController),
          const SizedBox(height: 16),
          Row(
            spacing: 16,
            children: [
              Expanded(child: AppInputText(controller: _ageController)),
              SizedBox(
                width: 200,
                child: CustomDropdownMenu(
                  hintText: "Gender",
                  icon: const AppImage(image: "arrow_down.svg"),
                  value: selectedGender,
                  onChanged: (value) {
                    print(value);
                  },
                  items: const [
                    DropdownMenuItem(value: "M", child: Text('Male')),
                    DropdownMenuItem(value: "F", child: Text('Female')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onPressed: () {},
                  text: "Save",
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ChangePasswordView(editPassword: true),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  "Change Password",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                AppImage(
                  image: "edit.svg",
                  svgColorFilter: ColorFilter.mode(theme, blendMode),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
