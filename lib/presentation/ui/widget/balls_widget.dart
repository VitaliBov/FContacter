import 'package:f_contacter/res/images.dart';
import 'package:flutter/widgets.dart';

class BallsWidget extends StatefulWidget {
  BallsWidget({Key key}) : super(key: key);

  BallsState createState() => BallsState();
}

class BallsState extends State<BallsWidget> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
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
    return FadeTransition(
        opacity: _animation,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.bottomCenter,
                    image: AssetImage(AppImages.backgroundWelcome)
                )
            )
        )
    );
  }
}