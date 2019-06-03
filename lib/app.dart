import 'package:f_contacter/presentation/bloc/app_bloc.dart';
import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:f_contacter/presentation/ui/login/login_screen.dart';
import 'package:f_contacter/presentation/ui/login/welcome_screen.dart';
import 'package:f_contacter/presentation/ui/main/main_screen.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    return StreamBuilder(
      stream: appBloc.isAuthorized,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
              title: AppStrings.appName,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: AppColors.colorBackgroundDefault,
                accentColor: AppColors.colorAccent,
                backgroundColor: AppColors.colorBackgroundDefault
              ),
              routes: {
                '/': (BuildContext context) => snapshot.data ? new MainScreen() : new WelcomeScreen(),
                '/login': (BuildContext context) => new LoginScreen(),
                '/main': (BuildContext context) => new MainScreen()
              }
          );
        } else {
          //TODO add splash
          return Container();
        }
      }
    );
  }
}