import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/presentation/ui/contacts/contacts_items.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:f_contacter/res/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactsItemWidget extends StatelessWidget {
  final ContactsItem data;

  ContactsItemWidget({
    Key key,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
    leading: AspectRatio(
        aspectRatio: 1/1,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                boxShadow:[
                  BoxShadow(
                      color: AppColors.colorShadow,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0)
                  )
                ]
            ),
            child: ClipOval(
                child: CachedNetworkImage(
                    imageUrl: data.user.image,
                    placeholder: (context, url) => SvgPicture.asset(AppImages.avatarPlaceholder),
                    errorWidget: (context, url, error) => SvgPicture.asset(AppImages.avatarPlaceholder),
                    fit: BoxFit.cover
                )
            )
        )
    ),
    title: Text(
        data.user.fullName,
        style: TextStyle(
            color: AppColors.colorPrimaryText,
            fontSize: 15.0,
            fontFamily: AppFonts.poppinsMedium,
            fontWeight: FontWeight.bold
        )
    ),
    subtitle: Text(
        data.user.position,
        style: TextStyle(
            color: AppColors.colorDetailText,
            fontSize: 15.0,
            fontFamily: AppFonts.poppinsLight
        )
    ),
    onTap: () => AppNavigator.goToContact(context, data.user)
  );
}