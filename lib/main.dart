import 'package:f_contacter/presentation/ui/app.dart';
import 'package:f_contacter/helpers/connection_status_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        _initConnectionListener();
        runApp(App());
      });
}

void _initConnectionListener() => ConnectionStatusListener.getInstance().initialize();