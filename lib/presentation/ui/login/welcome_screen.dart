import 'package:f_contacter/presentation/ui/widget/balls_widget.dart';
import 'package:f_contacter/presentation/ui/widget/login_button.dart';
import 'package:f_contacter/presentation/ui/widget/logo_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 18,
            child: BallsWidget()
          ),
          Expanded(
              flex: 5,
              child: LogoWidget()
          ),
          Expanded(
              flex: 3,
              child: LoginButton()
          ),
          Expanded(
              flex: 2,
              child: Container()
          )
        ]
      )
    );
  }
}