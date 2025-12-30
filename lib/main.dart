import 'package:flutter/material.dart';
import 'package:tranquility/views/home/view/view.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const Tranquility(),),
  );
}

class Tranquility extends StatelessWidget {
  const Tranquility({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        drawerTheme: DrawerThemeData(
          width: 340,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          shadowColor: Theme.of(context).primaryColor,
        ),
        primaryColor: const Color(0xFF284243),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        hintColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSeed(
          ///primary Text Color
          primary: const Color(0xFF000000),

          ///primary Container Color
          primaryContainer: const Color(0xFF284243),
          seedColor: const Color(0xFF284243),
          outline: const Color(0xFF284243).withValues(alpha: 0.3),
          surface: const Color(0xFF284243).withValues(alpha: 0.05),
          error: const Color(0xFFF60000),
          errorContainer: const Color(0xFFFF3A3A),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: "MysteryQuest",
            color: Color(0xFF284243),
            fontSize: 50,
          ),
          headlineMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 700)],
            fontSize: 18,
          ),
          titleLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 700)],
            fontSize: 32,
          ),
          titleMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF000000),
            fontVariations: [FontVariation("wght", 500)],
            fontSize: 24,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF),
            fontVariations: [FontVariation("wght", 700)],
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF),
            fontVariations: [FontVariation("wght", 500)],
            fontSize: 20,
          ),
          displayLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 500)],
            fontSize: 40,
          ),displayMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 500)],
            fontSize: 20,
          ),
          displaySmall: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF),
            fontVariations: [FontVariation("wght", 400)],
            fontSize: 20,
          ),
          labelLarge: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF000000),
            fontVariations: [FontVariation("wght", 400)],
            fontSize: 16,
          ),
          labelMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 400)],
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF000000),
            fontVariations: [FontVariation("wght", 400)],
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
