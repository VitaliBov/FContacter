import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/navigation/platform_route.dart';
import 'package:f_contacter/presentation/ui/contact/contact_screen.dart';
import 'package:f_contacter/presentation/ui/image/image_screen.dart';
import 'package:f_contacter/presentation/ui/login/login_screen.dart';
import 'package:f_contacter/presentation/ui/main/main_screen.dart';
import 'package:f_contacter/presentation/ui/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static goToWelcome(BuildContext context) => _forwardToFirst(context, WelcomeScreen());

  static goToLogin(BuildContext context) => _replace(context, LoginScreen());
  static goToMain(BuildContext context) => _replace(context, MainScreen());

  static goToContact(BuildContext context, User user) => _forward(context, ContactScreen(user));

  static goToImage(BuildContext context, String url) => _forward(context, ImageScreen(url));

  static closeScreen(BuildContext context) => _back(context);
  static closeDialog(BuildContext context) => _back(context);
}

_forward(BuildContext context, Widget widget) {
  Navigator.of(context).push(
      platformPageRoute(builder: (_) => widget)
  );
}

_replace(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
      platformPageRoute(builder: (_) => widget)
  );
}

_forwardToFirst(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      platformPageRoute(builder: (_) => widget),
      (_) => false
  );
}

_back(BuildContext context) {
  Navigator.of(context).pop();
}