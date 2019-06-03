import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserFieldWidget extends StatelessWidget{
  UserFieldWidget({
    Key key,
    this.image,
    this.text,
    this.onTap
  }) : super(key: key);

  final String image;
  final String text;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: SvgPicture.asset(image)
                  ),
                  Expanded(
                      flex: 20,
                      child: Text(
                          text,
                          style: TextStyle(
                              color: AppColors.colorPrimaryText,
                              fontSize: 16.0,
                              fontFamily: AppFonts.poppinsRegular
                          )
                      )
                  )
                ]
            )
        )
      )
    );
  }
}