import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tranquility/core/widgets/app_Image.dart';
import 'package:tranquility/core/widgets/app_text.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final text = "The only way to do great work is to love what you do";
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        const Positioned.fill(
          child: AppImage(image: "background_image.jpg", fit: BoxFit.cover),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
          ),
        ),
        Card(
          color: theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 13),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppImage(image: "qq.svg"),
                AppText(
                  "“ $text “",
                  textAlign: TextAlign.center,
                ),
                const AppText("Steve Jobs", textAlign: TextAlign.end),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: text,),
                    );

                    // scaffoldMessenger.showSnackBar(
                    //   SnackBar(
                    //     content: const AppText(
                    //       "Copied",
                    //       textAlign: TextAlign.center,
                    //     ),
                    //     elevation: 10,
                    //     backgroundColor: theme.scaffoldBackgroundColor
                    //         .withValues(alpha: 0.75),
                    //     duration: const Duration(milliseconds: 1200),
                    //     behavior: SnackBarBehavior.floating,
                    //     margin: const EdgeInsetsDirectional.symmetric(
                    //       horizontal: 100,
                    //     ),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //   ),
                    // );
                  },
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(bottom: 36),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 7,
                        children: [
                          AppText("Copy"),
                          AppImage(image: "copy.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
