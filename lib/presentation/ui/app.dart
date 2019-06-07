import 'package:f_contacter/presentation/bloc/app/app_bloc.dart';
import 'package:f_contacter/presentation/bloc/app/app_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/app/app_bloc_state.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  State createState() => AppState();
}

class AppState extends State<App> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc();
    _appBloc.dispatch(AppBlocEventInit());
  }

  @override
  void dispose() {
    _appBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _appBloc,
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.colorBackgroundDefault,
            accentColor: AppColors.colorAccent,
            backgroundColor: AppColors.colorBackgroundDefault
          ),
        home: BlocListener(
            bloc: _appBloc,
            listener: (context, state) {
              if (state is AppBlocStateSuccess) {
                if (state.isAuthorized) {
                  AppNavigator.goToMain(context);
                } else {
                  AppNavigator.goToWelcome(context);
                }
              }
            },
            child: Scaffold(
              body: Container()
            )
        )
      )
    );
  }
}