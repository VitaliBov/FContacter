import 'package:f_contacter/presentation/bloc/logout/logout_bloc.dart';
import 'package:f_contacter/presentation/bloc/logout/logout_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/logout/logout_bloc_state.dart';
import 'package:f_contacter/presentation/bloc/profile/profile_bloc.dart';
import 'package:f_contacter/presentation/bloc/profile/profile_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/profile/profile_bloc_state.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/widget/user_widget.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin<ProfileScreen> {
  ProfileBloc _profileBloc;
  LogoutBloc _logoutBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.dispatch(ProfileBlocEventLoad());
    _logoutBloc = LogoutBloc();
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    _logoutBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _logoutBloc,
      listener: (context, state) {
        if (state is LogoutBlocStateSuccess) {
          AppNavigator.goToWelcome(context);
        }
      },
      child: BlocBuilder<LogoutBlocEvent, LogoutBlocState>(
          bloc: _logoutBloc,
          builder: (context, state) {
            if (state is LogoutBlocStateEmpty) {
              return Scaffold(
                  appBar: AppBar(
                      title: const Text(AppStrings.profileScreenName),
                      elevation: 0.0
                  ),
                  body: _profileWidget(_logoutBloc)
              );
            }
            if (state is LogoutBlocStateError) {
              return _loadingWidget();
              //TODO add error
            }
            if (state is LogoutBlocStateLoading) {
              return _loadingWidget();
            }
            if (state is LogoutBlocStateSuccess) {
              return Scaffold();
            }
          }
      )
    );
  }

  Widget _profileWidget(LogoutBloc logoutBloc) {
    return BlocProvider(
      bloc: _profileBloc,
      child: BlocBuilder<ProfileBlocEvent, ProfileBlocState>(
          bloc: _profileBloc,
          builder: (context, state) {
            if (state is ProfileBlocStateSuccess) {
              return Column(
                  children: <Widget>[
                    Expanded(
                        flex: 10,
                        child: UserWidget(user: state.user)
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 2,
                        child: _logOutButton(context, logoutBloc)
                    )
                  ]
              );
            }
            if (state is ProfileBlocStateError) {
              return _loadingWidget();
              //TODO add error
            }
            if (state is ProfileBlocStateLoading) {
              return _loadingWidget();
            }
          }
      )
    );
  }

  //TODO add loading widget
  Widget _loadingWidget() => Scaffold(
    body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator()
    )
  );

  Widget _logOutButton(BuildContext context, LogoutBloc logoutBloc) => GestureDetector(
      onTap: () => _showDialog(context, logoutBloc),
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

  _showDialog(BuildContext context, LogoutBloc logoutBloc) => showDialog(
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
                    AppNavigator.closeDialog(context);
                    logoutBloc.dispatch(LogoutBlocEventLogout());
                  }
              )
            ]
        );
      });

  @override
  bool get wantKeepAlive => true;
}