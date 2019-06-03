import 'package:f_contacter/entity/user.dart';
import 'package:f_contacter/presentation/ui/widget/status_widget.dart';
import 'package:f_contacter/presentation/ui/widget/user_field_widget.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:f_contacter/res/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class UserWidget extends StatelessWidget {
  UserWidget({
    Key key,
    this.user
  }) : super(key: key);

  final User user;

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(flex: 3, child: _avatar()),
          Expanded(flex: 1, child: _name()),
          Expanded(flex: 1, child: _position()),
          Expanded(flex: 5, child: StatusWidget(status: user.status.text)),
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 2, child: UserFieldWidget(image: AppImages.icPhone, text: user.phone, onTap: _savePhone)),
          Expanded(flex: 2, child: UserFieldWidget(image: AppImages.icEmail, text: user.email, onTap: _sendEmail))
        ]
    );
  }

  Widget _avatar() {
    return AspectRatio(
        aspectRatio: 1/1,
        child: Container(
            margin: EdgeInsets.all(
                10.0
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                boxShadow:[
                  BoxShadow(
                      color: AppColors.colorShadow,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0)
                  )
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user.image)
                )
            )
        )
    );
  }

  Widget _name() => Text(
      user.fullName,
      style: TextStyle(
          color: AppColors.colorPrimaryText,
          fontSize: 17.0,
          fontFamily: AppFonts.poppinsMedium,
          fontWeight: FontWeight.bold
      )
  );

  Widget _position() => Text(
      user.position,
      style: TextStyle(
        color: AppColors.colorDetailText,
        fontSize: 17.0,
        fontFamily: AppFonts.poppinsLight
      )
  );

  _savePhone() async {
    var phone = "tel:${user.phone}";
    if (await canLaunch(phone)) await launch(phone);
  }

  _sendEmail() async {
    var email = "mailto:${user.email}";
    if (await canLaunch(email)) await launch(email);
  }
}