import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';

import '../core/widgets/app_Image.dart';
import '../core/widgets/app_bar.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        haveTitle: true,
        haveSearchBar: false,
        title: "Suggestions",
      ),
      body: Column(
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
                const AppInputText(hintText: "Subject"),
                const SizedBox(height: 16),
                const AppInputText(hintText: "body", maxLines: 10),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () {},
                        text: "Send Message",
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
