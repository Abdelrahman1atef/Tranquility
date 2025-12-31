import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_Image.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';

import '../core/widgets/app_bar.dart';
import 'home/pages/chats.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.item});

  final ChatsItem item;

  @override
  Widget build(BuildContext context) {
    final messages = [
      const ChatBubble(text: "Hello How are you?", isSender: true),
      const ChatBubble(
          text: "Hello! I'm just a computer program, so I don't have feelings in the same way humans do, but I'm here and ready to assist you. How can I help you today?", isSender: false),
      const ChatBubble(text: "I feel upset", isSender: true),
      const ChatBubble(text: "I'm sorry to hear that you're feeling upset. If you'd like, you can share what's on your mind, and I'm here to listen and offer support or guidance if you need it. Remember, it's okay to feel upset sometimes, and it's important to take care of yourself.", isSender: false),
      const ChatBubble(text: "I'm sorry to hear that you're feeling upset. If you'd like, you can share what's on your mind, and I'm here to listen and offer support or guidance if you need it. Remember, it's okay to feel upset sometimes, and it's important to take care of yourself.", isSender: false),
    ];
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        haveTitle: true,
        haveSearchBar: false,
        centerTitle: true,
        title: item.title,
        haveAction: true,
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsetsGeometry.only(
          bottom: kBottomNavigationBarHeight / 2,
          left: 13,
          right: 13,
        ),
        child: Row(
          spacing: 14,
          children: [
            Expanded(
              child: AppInputText(
                maxLines: 1,
                borderWidth: 1,
                hintText: "write your message",
                borderColor: theme.primaryColor,
                fillColor: theme.colorScheme.surface,
              ),
            ),
            AppButton(
              onPressed: () {},
              isChildIcon: true,
              borderRadius: 50,
              icon: const AppImage(image: "send_message.svg"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.only(bottom: 10),
        child: ListView.separated(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 27),
          itemCount: messages.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => messages[index]
        ),
      ),
    );
  }
}



class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.text,
    required this.isSender,
  });

  final String text;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment:
      isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSender)
              const AppImage(image: "profile.png",height: 36,),
            SizedBox(width: isSender ? 0 : 7),
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: isSender
                    ? theme.colorScheme.primaryContainer
                    : const Color(0xFFAEAEAE).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Expanded(
                child: AppText(
                  text,
                  textAlign: isSender ? TextAlign.end : TextAlign.start,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: isSender
                        ? theme.scaffoldBackgroundColor
                        : theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

