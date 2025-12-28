import 'package:flutter/material.dart';
import 'package:tranquility/views/login.dart';
import 'package:tranquility/views/onboarding.dart';
import 'package:tranquility/views/splash.dart';

void main() {
  runApp(const Tranquility());
}

class Tranquility extends StatelessWidget {
  const Tranquility({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF284243),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        hintColor: const Color(0xFF000000),
        colorScheme: ColorScheme.fromSeed(
          ///primary Text Color
          primary: const Color(0xFF000000),

          ///primary Container Color
          primaryContainer: const Color(0xFF284243),
          seedColor: const Color(0xFF284243),
          outline: Color(0xFF284243).withValues(alpha: 0.3),
          surface: Color(0xFF284243).withValues(alpha: 0.1),
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
          titleMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
            fontVariations: [FontVariation("wght", 700)],
            fontSize: 32,
          ),
          bodyMedium:TextStyle(
            fontFamily: "Inter",
            color: Color(0xFFFFFFFF),
            fontVariations: [FontVariation("wght", 500)],
            fontSize: 20,
          ) ,
          displayMedium: TextStyle(
            fontFamily: "Inter",
            color: Color(0xFF284243),
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
