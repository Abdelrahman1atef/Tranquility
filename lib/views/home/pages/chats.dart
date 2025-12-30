import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_Image.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: chats.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(image: "chat_empty.svg"),
                  SizedBox(height: 6),
                  AppText("You don’t have any Chats yet."),
                ],
              ),
            )
          : ListView.separated(
              itemCount: chats.length,
              padding: const EdgeInsetsGeometry.only(
                right: 23,
                left: 23,
                top: kToolbarHeight / 2,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = chats[index];
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatView(item: item),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsetsGeometry.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.primary,
                            ),
                            borderRadius: BorderRadiusGeometry.circular(9),
                            color: theme.colorScheme.surface,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                item.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              AppText(
                                item.time,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          setState(() {
                            chats.remove(chats[index]);
                          });
                        },
                        child: const AppImage(image: "delete_chat.svg")),
                  ],
                );
              },
            ),
    );
  }
}

final emptyChats = [];
final chats = [
  ChatsItem(title: "About Work", time: "10/12/2021"),
  ChatsItem(title: "About My Family", time: "10/12/2021"),
  ChatsItem(title: "My self", time: "10/12/2021"),
];

class ChatsItem {
  final String title;
  final String time;

  ChatsItem({required this.title, required this.time});
}
