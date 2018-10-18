import 'package:f_contacter/presentation/main/main_screen.dart';
import 'package:f_contacter/presentation/login/welcome_screen.dart';
import 'package:f_contacter/scoped_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContacterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => MaterialApp(
            title: "Contacter",
            theme: ThemeData.light(),
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => model.isAuthorized()
                  ? MainScreen()
                  : WelcomeScreen(),
              '/login': (BuildContext context) => WelcomeScreen(),
              '/main': (BuildContext context) => MainScreen()
            })
    );
  }
}