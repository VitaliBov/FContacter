import 'package:f_contacter/app.dart';
import 'package:f_contacter/scoped_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {

  runApp(ScopedModel<AppModel>(
      model: AppModel(), child: ContacterApp()));
}