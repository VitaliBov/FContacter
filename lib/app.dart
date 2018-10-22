import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/logging.dart';
import 'package:f_contacter/presentation/login/login_screen.dart';
import 'package:f_contacter/presentation/main/main_screen.dart';
import 'package:f_contacter/scoped_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContacterApp extends StatefulWidget {
  @override
  ContacterAppState createState() => ContacterAppState();
}

class ContacterAppState extends State<ContacterApp> {
  final profileRepository = ProfileRepository();
  var isTokenLoaded = false;
  var isTokenValid;

  @override
  void initState() {
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    if (isTokenLoaded) {
      return ScopedModelDescendant<AppModel>(
          builder: (context, child, model) =>
              MaterialApp(
                  title: "Contacter",
                  theme: ThemeData.light(),
                  routes: {
                    '/': (BuildContext context) => isTokenValid
                        ? new MainScreen()
                        : new LoginScreen(),
                    '/login': (BuildContext context) => new LoginScreen(),
                    '/main': (BuildContext context) => new MainScreen()
                  })
      );
    } else {
      return Container();
    }
  }

  void checkToken() async {
    try {
      isTokenValid = await profileRepository.isAuthorized();
      setState(() {
        isTokenLoaded = true;
      });
    } catch (e) {
      printLog(e.toString());
    }
  }
}