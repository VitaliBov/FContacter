import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/bloc/contact/contact_bloc.dart';
import 'package:f_contacter/presentation/bloc/contact/contact_bloc_event.dart';
import 'package:f_contacter/presentation/bloc/contact/contact_bloc_state.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/widget/button.dart';
import 'package:f_contacter/presentation/ui/widget/user_widget.dart';
import 'package:f_contacter/res/images.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactScreen extends StatefulWidget {
  final User user;

  ContactScreen(this.user, {Key key}) : super(key: key);

  @override
  State createState() => ContactState();
}

class ContactState extends State<ContactScreen> {
  ContactBloc _contactBloc;

  @override
  void initState() {
    super.initState();
    _contactBloc = ContactBloc();
    _contactBloc.dispatch(ContactBlocEventLoad(widget.user));
  }

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: SvgPicture.asset(AppImages.icArrow),
              onPressed: () => AppNavigator.closeScreen(context)
          ),
          elevation: 0.0
      ),
      body: _profileWidget()
  );

  Widget _profileWidget() => BlocProvider(
      bloc: _contactBloc,
      child: BlocBuilder<ContactBlocEvent, ContactBlocState>(
          bloc: _contactBloc,
          builder: (context, state) {
            if (state is ContactBlocStateSuccess) {
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
                        child: _saveContactButton(context)
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    )
                  ]
              );
            }
            if (state is ContactBlocStateError) {
              return _loadingWidget();
              //TODO add error
            }
            if (state is ContactBlocStateLoading) {
              return _loadingWidget();
            }
          }
      )
  );

  Widget _saveContactButton(BuildContext context) => Container(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Button(
            title: AppStrings.contactButtonSave,
            onTap: () {
              //TODO add action
            },
          )
      )
  );

  //TODO add loading widget
  Widget _loadingWidget() => Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator()
      )
  );
}