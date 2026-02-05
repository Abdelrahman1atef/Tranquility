import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/logic/cash_helper.dart';
import 'package:tranquility/core/logic/helper_methods.dart';
import 'package:tranquility/core/network/dio_helper.dart';
import 'package:tranquility/core/widgets/app_add_image.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';

import '../../../core/widgets/app_Image.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_drop_menu.dart';
import '../../change_password.dart';
import '../../login/model.dart';


class ProfileRequest {
  final String age;
  final String gender;
  final String? image;

  ProfileRequest({required this.age, required this.gender, required this.image});

  FormData toFormData() {
    final formData = FormData();
    formData.fields.add(MapEntry("age", age.toString()));
    formData.fields.add(MapEntry("gender", gender));
    if (image!.startsWith("http")||image!.startsWith("https")) return formData;
    formData.fields.add(MapEntry("image", image!));
    return formData;
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _key = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedImage = "";
  String _selectedGender = "";
  DataStates _state = DataStates.uninitialized;


  @override
  void initState() {
    Data? data = CashHelper.getUserData();
    _usernameController.text = data?.name ?? "";
    _emailController.text = data?.email ?? "";
    _ageController.text = data?.age.toString() ?? "";
    _selectedImage = data?.imageUrl ?? "";
    _selectedGender = data?.gender ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile({required ProfileRequest data}) async {
    _state = DataStates.loading;
    setState(() {});
    final response = await DioHelper.putData(endpoint: "api/Profile", data: data.toFormData());
    if (response.isSuccess) {
      CashHelper.setData("age",int.parse(_ageController.text));
      CashHelper.setData("gender",_selectedGender);
      CashHelper.setData("imageUrl",_selectedImage);
      showMsg(response.msg);
      _state = DataStates.loaded;
    }
    else {
      showMsg(response.msg, isError: true);
      _state = DataStates.error;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme
        .primary;
    final blendMode = BlendMode.srcIn;
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            AppAddImage(image: _selectedImage, onChange: (value) => _selectedImage = value),
            const SizedBox(height: 40),
            AppInputText(controller: _usernameController,enabled: false,),
            const SizedBox(height: 16),
            AppInputText(controller: _emailController,enabled: false,),
            const SizedBox(height: 16),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: AppInputText(
                    controller: _ageController,
                    hintText: "Age",
                    textInputType: const TextInputType.numberWithOptions(signed: false, decimal: false),
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
                ),
                SizedBox(
                  width: 200,
                  child: AppDropMenu(
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: () async {
                      if (!_key.currentState!.validate()) return;
                      final data = ProfileRequest(
                        age: _ageController.text,
                        gender: _selectedGender,
                        image: _selectedImage,
                      );
                      await _updateProfile(data: data);
                    },
                    widget: _state == DataStates.loading
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : AppText( "Save",style: Theme.of(context).textTheme.bodyMedium),
                    padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => goto(const ChangePasswordView(changePassword: true)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText("Change Password", style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall),
                  AppImage(image: "edit.svg", svgColorFilter: ColorFilter.mode(theme, blendMode)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



