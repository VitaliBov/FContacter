import 'package:f_contacter/logging.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;

PageRoute<T> platformPageRoute<T>({
  WidgetBuilder builder,
  RouteSettings settings,
  bool maintainState = true,
  bool fullscreenDialog = false,
  String iosTitle,
}) {
  if (Platform.isAndroid) {
    if (AppDebugger.isAndroid == null) {
      return _materialRoute<T>(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
    } else {
      if (AppDebugger.isAndroid) {
        return _materialRoute<T>(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog);
      } else {
        return _cupertinoRoute(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog, title: iosTitle);
      }
    }
  } else {
    return _cupertinoRoute(builder: builder, settings: settings, maintainState: maintainState, fullscreenDialog: fullscreenDialog, title: iosTitle);
  }
}

PageRoute<T> _materialRoute<T>({
  WidgetBuilder builder,
  RouteSettings settings,
  bool maintainState,
  bool fullscreenDialog
}) => MaterialPageRoute<T>(
  builder: builder,
  settings: settings,
  maintainState: maintainState,
  fullscreenDialog: fullscreenDialog,
);

PageRoute _cupertinoRoute({
  WidgetBuilder builder,
  RouteSettings settings,
  bool maintainState,
  bool fullscreenDialog,
  String title
}) => CupertinoPageRoute(
    builder: builder,
    settings: settings,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    title: title
);