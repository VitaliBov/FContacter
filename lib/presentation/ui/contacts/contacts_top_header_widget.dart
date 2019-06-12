import 'package:f_contacter/presentation/ui/contacts/contacts_items.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactsTopHeaderWidget extends StatelessWidget {
  final ContactsTopHeader data;

  ContactsTopHeaderWidget({
    Key key,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 8.0),
    title: Text(
      data.title,
      style: TextStyle(
          color: AppColors.colorPrimaryText,
          fontSize: 20.0,
          fontFamily: AppFonts.poppinsMedium,
          fontWeight: FontWeight.bold
      )
    ),
    subtitle: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
            data.subTitle,
            style: TextStyle(
                color: AppColors.colorDetailText,
                fontSize: 16.0,
                fontFamily: AppFonts.poppinsLight
            )
        )
    )
  );
}