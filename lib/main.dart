import 'package:f_contacter/app.dart';
import 'package:f_contacter/helpers/connection_status_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/bloc/app_bloc.dart';
import 'presentation/bloc/bloc_provider.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
        _initConnectionListener();
        runApp(
            BlocProvider<AppBloc>(
                bloc: AppBloc(),
                child: App()
            )
        );
      });
}

void _initConnectionListener() => ConnectionStatusListener.getInstance().initialize();