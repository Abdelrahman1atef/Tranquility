import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'cash_helper.dart';

final navKey = GlobalKey<NavigatorState>();
final context = navKey.currentContext;
final theme = Theme.of(context!);
final ColorScheme color = theme.colorScheme;

void goto(Widget page, {bool canPop = true, int? delayInMilliSeconds}) {
  void action() {
    Navigator.pushAndRemoveUntil(context!, MaterialPageRoute<void>(builder: (context) => page), (route) => canPop);
  }

  if (delayInMilliSeconds != null) {
    Future.delayed(Duration(milliseconds: delayInMilliSeconds), action);
  } else {
    action();
  }
}

void showMsg(String? msg, {bool isError = false}) {
  if (msg == null) return;
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: isError ? color.errorContainer :  color.primaryContainer,
      content: Text(
        msg,
        style: Theme.of(context!).textTheme.bodyMedium,
      ),
    ),
  );
}

bool validateEmail(String value) {
  return RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(value);
}

Future<void> initFcm() async {
  await FirebaseMessaging.instance.requestPermission();

  final token = await FirebaseMessaging.instance.getToken();
  if (token != null) {
    await CashHelper.setFcmToken(token);
  }
}
String getPlatform() {
  return Platform.isAndroid ? 'android' : 'ios';
}

