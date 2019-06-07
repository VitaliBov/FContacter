import 'dart:async';

import 'package:f_contacter/entity/error_type.dart';
import 'package:f_contacter/helpers/connection_status_listener.dart';
import 'package:f_contacter/presentation/bloc/login/login_bloc.dart';
import 'package:f_contacter/presentation/bloc/login/login_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/login/login_bloc_state.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/widget/error_widget.dart' as error;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  static const _redirectUrl = "https://orangesoft.by/";
  static const _query = "code";
  static const _url = "https://www.teamwork.com/launchpad/login?redirect_uri=$_redirectUrl";
  final _webViewPlugin = new FlutterWebviewPlugin();
  LoginBloc _loginBloc;
  StreamSubscription _urlStateSubscription;
  StreamSubscription _networkConnectionSubscription;
  bool _isNetworkAvailable;
  String _code;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    ConnectionStatusListener.getInstance().checkConnection().then((hasConnection) {
      setState(() {
        _isNetworkAvailable = hasConnection;
      });
      _initUrlStateSubscription();
      _initNetworkConnectionSubscription();
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    _networkConnectionSubscription.cancel();
    _urlStateSubscription.cancel();
    _webViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginBlocStateSuccess) {
            AppNavigator.goToMain(context);
          }
        },
        child: BlocBuilder<LoginBlocEvent, LoginBlocState>(
            bloc: _loginBloc,
            builder: (context, state) {
              if (state is LoginBlocStateEmpty) {
                if (_isNetworkAvailable == null) {
                  return Scaffold(
                      body: Container()
                  );
                } else {
                  if (_isNetworkAvailable) {
                    return _webViewWidget();
                  } else {
                    return error.ErrorWidget(errorType: ErrorType.Network);
                  }
                }
              }
              if (state is LoginBlocStateError) {
                return _loadingWidget();
                //TODO add error
              }
              if (state is LoginBlocStateLoading) {
                return _loadingWidget();
              }
              if (state is LoginBlocStateSuccess) {
                return Scaffold();
              }
            }
        )
    );
  }

  void _initUrlStateSubscription() {
    _urlStateSubscription = _webViewPlugin.onStateChanged.listen((state) {
      setState(() {
        if (_isLoadingStarted(state)) {
          Uri uri = Uri.parse(state.url);
          if (uri.hasQuery) {
            _code = uri.queryParameters[_query];
            _loginBloc.dispatch(LoginBlocEventLogin(_code));
          }
        }
      });
    });
  }

  void _initNetworkConnectionSubscription() {
    _networkConnectionSubscription = ConnectionStatusListener.getInstance().connectionChange.listen((hasConnection) {
      setState(() {
        _isNetworkAvailable = hasConnection;
      });
    });
  }

  Widget _webViewWidget() => WebviewScaffold(url: _url, withJavascript: true);
  Widget _loadingWidget() => Scaffold(body: CircularProgressIndicator());
  bool _isLoadingStarted(WebViewStateChanged state) => state.url.startsWith(_redirectUrl) && state.type == WebViewState.startLoad;
}