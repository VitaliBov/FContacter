import 'package:equatable/equatable.dart';

abstract class AppBlocEvent extends Equatable {
  AppBlocEvent([List props = const []]) : super(props);
}

class AppBlocEventInit extends AppBlocEvent {}