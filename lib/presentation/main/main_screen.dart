import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
                padding: EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: FlutterLogo(
                          size: 200.0,
                        ),
                      ),
                    ),
                    // TODO bottom navigation
                  ],
                )
            )
        )
    );
  }
}