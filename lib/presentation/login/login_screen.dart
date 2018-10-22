import 'dart:async';

import 'package:f_contacter/data/entity/user.dart';
import 'package:f_contacter/data/repository/auth_repository.dart';
import 'package:f_contacter/data/repository/profile_repository.dart';
import 'package:f_contacter/navigator.dart';
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
  final authRepository = AuthRepository();
  final profileRepository = ProfileRepository();
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
              _getUser(code);
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

  void _getUser(String code) async {
    var authResult = await authRepository.getToken(code);
    Future.wait([_saveToken(authResult.token), _saveUser(authResult.user)])
        .then((authResult) => _completed())
        .catchError((e) => print("Error"));
  }

  Future _saveToken(String token) async {
    try {
      profileRepository.saveToken(token);
    } catch (e) {}
  }

  Future _saveUser(User user) async {
    try {
      profileRepository.saveUser(user);
    } catch (e) {}
  }

  void _completed() {
    goToMain(context);
    webViewPlugin.close();
  }
}
