import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  Button({
    Key key,
    this.title,
    this.icon,
    this.onTap
  }) : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onTap;
  final double _elevation = 8.0;
  final double _shadowRadius = 20.0;

  //TODO add image
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            color: AppColors.colorAccent,
            splashColor: Colors.white12,
            elevation: _elevation,
            onPressed: () => onTap(),
            child: Text(
                title.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: AppFonts.poppinsMedium,
                    fontWeight: FontWeight.bold
                )
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(_shadowRadius)
            )
        )
    );
  }
}