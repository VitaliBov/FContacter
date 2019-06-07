import 'package:f_contacter/presentation/ui/login/login_screen.dart';
import 'package:f_contacter/presentation/ui/main/main_screen.dart';
import 'package:f_contacter/presentation/ui/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static goToWelcome(BuildContext context) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen()), (_) => false);
  static goToLogin(BuildContext context) => _replaceWidgetWithFade(context, LoginScreen());
  static goToMain(BuildContext context) => _replaceWidgetWithFade(context, MainScreen());
  static closeDialog(BuildContext context) => Navigator.of(context).pop();
}

_forwardWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
            child: child
        )
    )
  );
}

_replaceWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: animation,
              child: child
          )
      )
  );
}