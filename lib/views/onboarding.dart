import 'package:flutter/material.dart';
import 'package:tranquility/core/widgets/app_Image.dart';
import 'package:tranquility/core/widgets/app_text.dart';

import 'login.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = PageController();
  int currentPage = 0;
  final duration = Duration(milliseconds: 300);
  final curve = Curves.easeIn;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      currentPage = controller.page?.round() ?? 0;
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: PageView.builder(
        controller: controller,
        itemCount: onboardingItems.length,
        itemBuilder: (context, index) {
          final item = onboardingItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppImage(image: item.image),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          item.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 24),
                        AppText(
                          item.description
                              .split(' ')
                              .map(
                                (word) => word.isEmpty
                                    ? ''
                                    : word[0].toUpperCase() +
                                          word.substring(1).toLowerCase(),
                              )
                              .join(' '),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsetsGeometry.only(
                    bottom: 30,
                    right: 25,
                    left: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              if (index != onboardingItems.length - 1)
                      //todo add nav to next screen
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => LoginView(),),(route) => false,);
                        },
                        child: AppText(
                          "Skip",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
              if (index == onboardingItems.length - 1)
                      SizedBox.shrink(),
                      InkWell(
                        onTap: () {
                          if(index == onboardingItems.length - 1){
                            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => LoginView(),),(route) => false,);
                            return;
                          }
                          controller.animateToPage(
                              ++currentPage, duration: duration, curve: curve);
                        },
                        child: Container(
                          padding: EdgeInsetsGeometry.all(14),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: AppImage(image: "arrow.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

final onboardingItems = [
  OnboardingItem(
    image: "on_boarding2.jpg",
    title: "Feel Free",
    description:
        "because I'm the friendly chatbot here to assist you with anything you need.",
  ),
  OnboardingItem(
    image: "on_boarding1.jpg",
    title: "Ask For Anything",
    description:
        "I'm your friendly neighborhood chatbot ready to assist you with any questions or concerns.",
  ),
  OnboardingItem(
    image: "on_boarding3.jpg",
    title: "Your Secert is Save",
    description: "Our platform prioritizes your privacy and security",
  ),
];

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
