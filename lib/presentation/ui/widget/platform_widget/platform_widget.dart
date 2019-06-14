import 'package:f_contacter/logging.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

typedef T PlatformBuilder<T>(BuildContext context);

abstract class PlatformWidget<A extends Widget, I extends Widget> extends StatelessWidget {
  PlatformWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      if (AppDebugger.isAndroid == null) {
        return createAndroidWidget(context);
      } else {
        if (AppDebugger.isAndroid) {
          return createAndroidWidget(context);
        } else {
          return createIosWidget(context);
        }
      }
    } else if (Platform.isIOS) {
      return createIosWidget(context);
    }
    return throw new UnsupportedError('This platform is not supported: ${Platform.operatingSystem}');
  }

  A createAndroidWidget(BuildContext context);

  I createIosWidget(BuildContext context);
}