import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_input_text.dart';
import 'package:tranquility/core/widgets/app_text.dart';

import 'app_Image.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.haveTitle,
    required this.haveSearchBar,
    this.title,
    this.haveAction,
    this.centerTitle,
    this.haveDrawer,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final bool haveTitle, haveSearchBar;
  final bool? haveAction, centerTitle;
   final String? title;
  final bool? haveDrawer;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (haveSearchBar && haveTitle ? kToolbarHeight : 0),
  );
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: widget.centerTitle,
      title: widget.haveTitle
          ? Text(
              widget.title ?? "",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 30),
            )
          : null,
      actionsPadding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      actions: widget.haveAction ?? false
          ? [
              PopupMenuTheme(
                data: PopupMenuThemeData(
                  color: theme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  position: PopupMenuPosition.under,
                ),
                child: PopupMenuButton(
                  splashRadius: 16,

                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => AlertDialog(

                              title: AppText("Edit Title"),
                              content: SizedBox(
                                  height: 70,
                                  child: AppInputText(
                                    padding: EdgeInsetsGeometry.symmetric(vertical: 25),
                                  )),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        //todo add update of title if edit
                                        onPressed: () {
                                          setState(() {
                                          // widget.title = "koko";
                                          });
                                          Navigator.pop(context);
                                        },
                                        padding: EdgeInsetsGeometry.symmetric(vertical: 19),
                                        text: "Save",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Row(
                          spacing: 16,
                          children: [
                            AppImage(image: "edit_title.svg"),
                            AppText("Edit Title"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          spacing: 16,
                          children: [
                            const AppImage(image: "delete_chat.svg"),
                            AppText(
                              "Delete Chat",
                              style: TextStyle(color: theme.colorScheme.error),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                  child: const AppImage(image: "menu.svg"),
                ),
              ),
            ]
          : null,
      // bottom: widget.haveSearchBar
      //     ? PreferredSize(
      //         preferredSize: preferredSize,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: SearchBarTheme(
      //             data: Theme.of(context).searchBarTheme,
      //             child: SearchBar(
      //               hintText: "Search",
      //               hintStyle: WidgetStatePropertyAll(
      //                 Theme.of(context).textTheme.titleSmall,
      //               ),
      //               // trailing: const [AppImage(image: "search.svg")],
      //               // textStyle: WidgetStatePropertyAll(
      //               //   Theme.of(context).textTheme.displayMedium,
      //               // ),
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
    );
  }
}
