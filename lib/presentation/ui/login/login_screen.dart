import 'dart:async';

import 'package:f_contacter/entity/error_type.dart';
import 'package:f_contacter/helpers/connection_status_listener.dart';
import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:f_contacter/presentation/bloc/login_bloc.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/widget/error_widget.dart' as error;
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  static const _redirectUrl = "http://www.orangesoft.by/";
  static const _query = "code";
  static const _url = "https://www.teamwork.com/launchpad/login?redirect_uri=$_redirectUrl";
  final _webViewPlugin = new FlutterWebviewPlugin();
  LoginBloc _loginBloc;
  StreamSubscription _urlStateSubscription;
  StreamSubscription _networkConnectionSubscription;
  StreamSubscription _userSavingSubscription;
  bool _isShowProgress = false;
  bool _isNetworkAvailable;
  String _code;

  @override
  void initState() {
    super.initState();
    ConnectionStatusListener.getInstance().checkConnection().then((hasConnection) {
      setState(() {
        _isNetworkAvailable = hasConnection;
      });
      _initUrlStateSubscription();
      _initNetworkConnectionSubscription();
      _initUserSavingSubscription();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = _loginBloc ?? BlocProvider.of<LoginBloc>(context);
    if (_isNetworkAvailable == null) {
      return Scaffold(
        body: Container()
      );
    } else {
      if (_isNetworkAvailable) {
        if (_isShowProgress) {
          return _loadingWidget();
        } else {
          return _webViewWidget();
        }
      } else {
        return error.ErrorWidget(errorType: ErrorType.Network);
      }
    }
  }

  @override
  void dispose() {
    _networkConnectionSubscription.cancel();
    _urlStateSubscription.cancel();
    _userSavingSubscription.cancel();
    _webViewPlugin.dispose();
    super.dispose();
  }

  void _initUrlStateSubscription() {
    _urlStateSubscription = _webViewPlugin.onStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          if (_isLoadingStarted(state)) {
            Uri uri = Uri.parse(state.url);
            if (uri.hasQuery) {
              _code = uri.queryParameters[_query];
              _loginBloc.authorization(_code);
              _isShowProgress = true;
            }
          }
        });
      }
    });
  }

  void _initNetworkConnectionSubscription() {
    _networkConnectionSubscription = ConnectionStatusListener.getInstance().connectionChange.listen((hasConnection) {
      setState(() {
        _isNetworkAvailable = hasConnection;
      });
    });
  }

  void _initUserSavingSubscription() {
    _userSavingSubscription = _loginBloc.isUserSaved.listen((isSaved) {
      if (isSaved) {
        AppNavigator.goToMain(context);
      }
    });
  }

  Widget _webViewWidget() => WebviewScaffold(url: _url, withJavascript: true);
  Widget _loadingWidget() => Scaffold(body: CircularProgressIndicator());
  bool _isLoadingStarted(WebViewStateChanged state) => state.url.startsWith(_redirectUrl) && state.type == WebViewState.startLoad;
}