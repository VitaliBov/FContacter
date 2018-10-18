import 'package:f_contacter/colors.dart';
import 'package:f_contacter/navigator.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/welcome_background.png',
                  fit: BoxFit.fill,
                ),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Contacter",
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                    "Powered by Teamwork",
                                    style: TextStyle(
                                        color: colorDetailGrey,
                                        fontSize: 16.0,
                                    )
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 20.0),
                                    color: colorAccent,
                                    splashColor: Colors.white12,
                                    elevation: 8.0,
                                    onPressed: () => goToLogin(context),
                                    child: Text(
                                      "CONNECT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(10.0)),
                                  ),
                                )
                            ),
                          ],
                        )
                    )
                )
              ],
            )
        )
    );
  }
}