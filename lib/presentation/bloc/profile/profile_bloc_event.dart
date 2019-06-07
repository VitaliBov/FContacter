import 'package:equatable/equatable.dart';

abstract class ProfileBlocEvent extends Equatable {
  ProfileBlocEvent([List props = const []]) : super(props);
}

class ProfileBlocEventLoad extends ProfileBlocEvent {}