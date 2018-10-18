import 'package:f_contacter/presentation/login/login_screen.dart';
import 'package:f_contacter/presentation/main/main_screen.dart';
import 'package:flutter/material.dart';

goToLogin(BuildContext context) {
  _pushWidgetWithFade(context, LoginScreen());
}

goToMain(BuildContext context) {
  _pushWidgetWithFade(context, MainScreen());
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return widget;
        }),
  );
}