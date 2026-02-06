import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/home/view.dart';

import '../core/logic/helper_methods.dart';
import '../core/network/dio_helper.dart';
import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';

class SuggestionsView extends StatefulWidget {
  const SuggestionsView({super.key});

  @override
  State<SuggestionsView> createState() => _SuggestionsViewState();
}

class _SuggestionsViewState extends State<SuggestionsView> {
  final _key = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  DataStates _state = DataStates.uninitialized;

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _forgetPassword<T>() async {
    _state = DataStates.loading;
    setState(() {});
    final data = FormData.fromMap({
      "Subject": _subjectController.text,
      "Body": _bodyController.text,
    });
    final CustomResponse<T> response = await DioHelper.postData(endpoint: "api/Suggestions", data: data);
    if (response.isSuccess) {
      _state = DataStates.loaded;
      showMsg(response.msg);
      goto(const HomeView(), canPop: false);
    } else {
      showMsg(response.msg, isError: true);
      _state = DataStates.error;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(haveTitle: true, haveSearchBar: false, title: "Suggestions"),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [AppImage(image: "Suggest.png", width: 250)],
              ),
              AppText(
                "Tell Us How We Can Help",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    AppInputText(
                      controller: _subjectController,
                      hintText: "Subject",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Subject is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputText(
                      controller: _bodyController,
                      hintText: "body",
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Body is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onPressed: () async{
                              if (!_key.currentState!.validate()) return;
                              await _forgetPassword();
                            },
                            widget: _state == DataStates.loading
                                ? const CircularProgressIndicator(color: Colors.white,
                              constraints: BoxConstraints(minWidth: 30, minHeight: 30),)
                                : AppText( "Send Message",style: Theme.of(context).textTheme.bodyMedium),

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
      ),
    );
  }
}
