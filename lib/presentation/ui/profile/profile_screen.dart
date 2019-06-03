import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/bloc/bloc_provider.dart';
import 'package:f_contacter/presentation/bloc/profile_bloc.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/widget/user_widget.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileScreenName),
        elevation: 0.0
      ),
      body: StreamBuilder(
          stream: _profileBloc.isLogout,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              //TODO add navigation to welcome
              AppNavigator.goToWelcome(context);
              return _loadingWidget();
            } else {
              return _profileWidget(_profileBloc);
            }
          })
    );
  }

  //TODO add flutter bloc
  Widget _profileWidget(ProfileBloc bloc) {
    return StreamBuilder(
        stream: bloc.getUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: <Widget>[
                  Expanded(
                      flex: 10,
                      child: UserWidget(user: snapshot.data)
                  ),
                  Expanded(
                      flex: 1,
                      child: Container()
                  ),
                  Expanded(
                      flex: 2,
                      child: _logOutButton(context, bloc)
                  )
                ]
            );
          } else {
            _loadingWidget();
          }
        });
  }

  //TODO add loading widget
  Widget _loadingWidget() => Container(
      child: CircularProgressIndicator()
  );

  Widget _logOutButton(BuildContext context, ProfileBloc bloc) => GestureDetector(
    onTap: () => _showDialog(context, bloc),
    child: Container(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                AppStrings.profileLogout.toUpperCase(),
                style: TextStyle(
                    color: AppColors.colorRed,
                    fontSize: 16.0,
                    fontFamily: AppFonts.poppinsMedium,
                    fontWeight: FontWeight.bold
                )
            )
        )
    )
  );

  _showDialog(BuildContext context, ProfileBloc bloc) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.profileLogoutDescription),
          actions: [
            FlatButton(
              child: Text(AppStrings.no),
              onPressed: () => AppNavigator.closeDialog(context)
            ),
            FlatButton(
              child: Text(AppStrings.yes),
              onPressed: () {
                bloc.logout();
                AppNavigator.closeDialog(context);
              }
            )
          ]
        );
      });
}