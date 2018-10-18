import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  static const redirectUrl = "http://www.orangesoft.by/";
  static const query = "code";
  static const url = "https://www.teamwork.com/launchpad/login?redirect_uri=$redirectUrl";
  final webViewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  String code;

  @override
  void initState() {
    super.initState();
    webViewPlugin.close();
    _onUrlChanged = webViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          if (url.startsWith(redirectUrl)) {
            Uri uri = Uri.parse(url);
            if (uri.hasQuery) {
              code = uri.queryParameters[query];

              webViewPlugin.close();
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    webViewPlugin.dispose();
    super.dispose();
  }
}