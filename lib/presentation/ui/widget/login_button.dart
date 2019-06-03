import 'dart:math';

import 'package:f_contacter/presentation/navigation/navigator.dart';
import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  LoginButton({Key key}) : super(key: key);

  State<StatefulWidget> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;
  bool _withElevation = true;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LoginButtonPainter(_fraction, MediaQuery.of(context).size),
      child: _button(context),
    );
  }

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void reveal(BuildContext context) {
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          AppNavigator.goToLogin(context);
        }
      });
    _controller.forward();
  }

  void reset() {
    _fraction = 0.0;
  }

  Widget _button(BuildContext context) {
    double _elevation = _withElevation ? 8.0 : 0.0;
    double _shadowRadius = _withElevation ? 20.0 : 0.0;

    return Padding(
        padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                color: AppColors.colorAccent,
                splashColor: Colors.white12,
                elevation: _elevation,
                onPressed: () {
                  _withElevation = false;
                  reveal(context);
                },
                child: Text(
                  AppStrings.welcomeButtonTitle.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: AppFonts.poppinsMedium,
                      fontWeight: FontWeight.bold
                  )
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(_shadowRadius)
                )
            )
        )
    );
  }
}

class LoginButtonPainter extends CustomPainter {
  double _fraction = 0.0;
  Size _screenSize;

  LoginButtonPainter(this._fraction, this._screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.colorAccent
      ..style = PaintingStyle.fill;
    var finalRadius = sqrt(pow(_screenSize.width / 2, 2) + pow(_screenSize.height - 32.0 - 48.0, 2));
    var radius = 24.0 + finalRadius * _fraction;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(LoginButtonPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }
}