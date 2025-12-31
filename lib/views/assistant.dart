import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_Image.dart';
import 'package:tranquility/core/widgets/app_bar.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';

class AssistantView extends StatelessWidget {
  const AssistantView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        haveTitle: false,
        haveSearchBar: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: theme.primaryColor.withValues(alpha: 0.15),
            padding: const EdgeInsetsGeometry.only(
              top: kToolbarHeight * 3,
              bottom: 23,
            ),
            child: Column(
              children: [
                const AppImage(image: "assistent.svg"),
                AppText("Hey!", style: theme.textTheme.displayLarge),
                const SizedBox(height: 8),
                AppText(
                  "I’am your Personal Assistant",
                  style: theme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText("Make New Chat"),
                const SizedBox(height: 16),
                const AppInputText(
                  hintText: "Enter The Title Of Chat",
                  padding: EdgeInsetsGeometry.symmetric(vertical: 20,horizontal: 5),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: () {},
                        text: "Start Chat",
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
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
