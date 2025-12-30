import 'package:flutter/material.dart';

import 'app_Image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.haveTitle,
    required this.haveSearchBar,
    this.title,
    this.haveAction, this.centerTitle, this.haveDrawer,
  });

  final bool haveTitle, haveSearchBar;
  final bool? haveAction,centerTitle;
  final String? title;
  final bool? haveDrawer;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (haveSearchBar && haveTitle ? kToolbarHeight : 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 50,
      leading:haveDrawer??false? GestureDetector(
        // onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 16),
          child: const AppImage(image: "drawer.svg"),
        ),
      ):Navigator.canPop(context)
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 16),
                child: const AppImage(image: "arrow_back.svg"),
              ),
            )
          : null,
      centerTitle: centerTitle,
      title: haveTitle
          ? Text(
              title ?? "",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 30),
            )
          : null,
      actionsPadding: const EdgeInsetsDirectional.symmetric(horizontal: 24),
      // actions: haveAction ?? false
      //     ? [
      //         InkWell(
      //           onTap: () => Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const CheckOutView()),
      //           ),
      //           child: const AppImage(image: "check_out.svg", width: 30),
      //         ),
      //       ]
      //     : null,
      bottom: haveSearchBar
          ? PreferredSize(
              preferredSize: preferredSize,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBarTheme(
                  data: Theme.of(context).searchBarTheme,
                  child: SearchBar(
                    hintText: "Search",
                    hintStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.titleSmall,
                    ),
                    // trailing: const [AppImage(image: "search.svg")],
                    // textStyle: WidgetStatePropertyAll(
                    //   Theme.of(context).textTheme.displayMedium,
                    // ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
