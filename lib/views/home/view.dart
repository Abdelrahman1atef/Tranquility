import 'package:flutter/material.dart';
import 'package:tranquility/views/home/pages/chats.dart';
import 'package:tranquility/views/home/pages/profile.dart';
import 'package:tranquility/views/home/pages/quotes.dart';

import '../../core/widgets/app_Image.dart';
import '../../core/widgets/app_bar.dart';



class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final screens = [
    MainViewItem(widget:ChatsPage(),title:"Chats"  ),
    MainViewItem(widget: QuotesPage(),title:"Quotes"),
    MainViewItem(widget: ProfilePage(),title:"Profile"),
  ];
  int currentScreen = 0;
  String title = "Chats";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        haveTitle: true,
        haveSearchBar: false,
        centerTitle: false,
        haveDrawer: true,
        title: title,

      ),
      body: IndexedStack(index: currentScreen, children: screens.map((e) => e.widget).toList()),
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
        ),
        child: BottomNavigationBarTheme(
          data:  BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            enableFeedback: false,
            unselectedLabelStyle:TextStyle(
                fontSize: 14
            ) ,
            selectedLabelStyle: TextStyle(
                fontSize: 14
            ),
            selectedItemColor: Colors.white ,
            unselectedItemColor:  Colors.white,
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
                icon: AppImage(image:"unselected_chats.svg",width: 30,),
                activeIcon: AppImage(image:"selected_chats.svg",width: 30,),
                tooltip: "Chats",
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_quotes.svg",width: 30,),
                activeIcon: AppImage(image:"selected_quotes.svg",width: 30,),
                tooltip: "Quotes",
                label: "Quotes",
              ),
              BottomNavigationBarItem(
                icon: AppImage(image:"unselected_profile.svg",width: 30,),
                activeIcon: AppImage(image:"selected_profile.svg",width: 30,),
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
class MainViewItem {
  final Widget widget;
  final String title;
  MainViewItem({required this.widget, required this.title});
}