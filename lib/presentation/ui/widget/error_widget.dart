import 'package:f_contacter/entity/error_type.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/images.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorWidget extends StatelessWidget {
  final ErrorType errorType;

  ErrorWidget({Key key, this.errorType}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SvgPicture.asset(getImage())
              ),
              Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                      getTitle(),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.colorErrorText
                      )
                  )
              )
            ]
        )
      )
    );
  }

  String getImage() {
    switch(errorType) {
      case ErrorType.Network:
        return AppImages.errorNetwork;
      case ErrorType.NoContacts:
        return AppImages.errorOther;
      case ErrorType.Other:
        return AppImages.errorOther;
      default:
        return AppImages.errorOther;
    }
  }

  String getTitle() {
    switch(errorType) {
      case ErrorType.Network:
        return AppStrings.errorNetwork;
      case ErrorType.NoContacts:
        return AppStrings.errorContactsEmpty;
      case ErrorType.Other:
        return AppStrings.errorNotFound;
      default:
        return AppStrings.errorNotFound;
    }
  }
}