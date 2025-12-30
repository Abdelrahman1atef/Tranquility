import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_button.dart';
import 'package:tranquility/core/widgets/app_text.dart';
import 'package:tranquility/views/assistant.dart';
import 'package:tranquility/views/home/pages/chats.dart';
import 'package:tranquility/views/home/pages/profile.dart';
import 'package:tranquility/views/home/pages/quotes.dart';

import '../../../core/widgets/app_Image.dart';
import '../../../core/widgets/app_bar.dart';

part 'drawer.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final screens = [
    _MainViewItem(widget: const ChatsPage(), title: "Chats"),
    _MainViewItem(widget: const QuotesPage(), title: "Quotes"),
    _MainViewItem(widget: const ProfilePage(), title: "Profile"),
  ];
  int currentScreen = 0;
  late String title;

  @override
  void initState() {
    title = screens[0].title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      drawer: DrawerTheme(data: theme.drawerTheme, child: const AppDrawer()),
      floatingActionButton: AppButton(
        //todo add nav to assistant page
        onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => AssistantView(),)),
        isChildIcon: true,
        padding: const EdgeInsetsGeometry.all(10),
        icon: const AppImage(image: "assistent_white.svg",),
      ),
      appBar: CustomAppBar(
        haveTitle: true,
        haveSearchBar: false,
        centerTitle: false,
        title: title,
      ),
      body: IndexedStack(
        index: currentScreen,
        children: screens.map((e) => e.widget).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: theme.primaryColor),
        child: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            enableFeedback: false,
            unselectedLabelStyle: TextStyle(fontSize: 14),
            selectedLabelStyle: TextStyle(fontSize: 14),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            // selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
          ),
          child: BottomNavigationBar(
            currentIndex: currentScreen,
            onTap: (value) {
              setState(() {
                title = screens[value].title;
                currentScreen = value;
              });
            },

            items: const [
              BottomNavigationBarItem(
                icon: AppImage(image: "unselected_chats.svg", width: 30),
                activeIcon: AppImage(image: "selected_chats.svg", width: 30),
                tooltip: "Chats",
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image: "unselected_quotes.svg", width: 30),
                activeIcon: AppImage(image: "selected_quotes.svg", width: 30),
                tooltip: "Quotes",
                label: "Quotes",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image: "unselected_profile.svg", width: 30),
                activeIcon: AppImage(image: "selected_profile.svg", width: 30),
                tooltip: "Profile",
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainViewItem {
  final Widget widget;
  final String title;

  _MainViewItem({required this.widget, required this.title});
}
