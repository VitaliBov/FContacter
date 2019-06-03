import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:f_contacter/presentation/bloc/login_bloc.dart';
import 'package:f_contacter/presentation/ui/login/login_screen.dart';
import 'package:f_contacter/presentation/ui/main/main_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static goToWelcome(BuildContext context) => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  static goToLogin(BuildContext context) => _replaceWithFadeAndInitBloc(context, LoginScreen(), LoginBloc());
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

_forwardWithFadeAndInitBloc<T extends BlocBase>(BuildContext context, Widget widget, T bloc) {
  Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>  BlocProvider<T>(
              bloc: bloc,
              child: widget
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: animation,
              child: child
          )
      )
  );
}

_replaceWithFadeAndInitBloc<T extends BlocBase>(BuildContext context, Widget widget, T bloc) {
  Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider<T>(
              bloc: bloc,
              child: widget
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
              opacity: animation,
              child: child
          )
      )
  );
}