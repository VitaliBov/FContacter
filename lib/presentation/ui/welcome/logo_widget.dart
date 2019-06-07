import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/strings.dart';
import 'package:flutter/widgets.dart';

class LogoWidget extends StatefulWidget {
  LogoWidget({Key key}) : super(key: key);

  LogoState createState() => LogoState();
}

class LogoState extends State<LogoWidget> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FadeTransition(
          opacity: _animation,
          child: Column(children: <Widget>[
            Text(
                AppStrings.welcomeTitle,
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                    AppStrings.welcomeDescription,
                    style: TextStyle(
                      color: AppColors.colorDetailText,
                      fontSize: 16.0,
                    )
                )
            )
          ])
      )
    );
  }
}