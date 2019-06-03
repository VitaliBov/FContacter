import 'package:f_contacter/res/colors.dart';
import 'package:f_contacter/res/fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget({
    Key key,
    this.status
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return _StatusBorderWidget(
                  status: status,
                  height: constraints.maxHeight,
                  width: constraints.maxWidth
              );
            }
        )
    );
  }
}

class _StatusBorderWidget extends StatefulWidget {
  _StatusBorderWidget({
    Key key,
    this.status,
    this.height,
    this.width
  }) : super(key: key);

  final String status;
  final double height, width;

  State<StatefulWidget> createState() => _StatusBorderWidgetState(status, height, width);
}

class _StatusBorderWidgetState extends State<_StatusBorderWidget> {
  _StatusBorderWidgetState(
      this.status,
      this.height,
      this.width
  );

  final String status;
  final double height, width;
  final List<Offset> points = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      _initPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _StatusPainter(points),
        child: SizedBox(
          width: width,
          height: height,
          child: _statusText(),
        )
    );
  }

  Widget _statusText() => Padding(
        padding: EdgeInsets.fromLTRB(16.0, 29, 16.0, 16.0),
        child: Container(
            alignment: Alignment.center,
            child: Text(
                status,
                textAlign: TextAlign.center,
                maxLines: 5,
                style: TextStyle(
                    color: AppColors.colorDetailText,
                    fontSize: 14.0,
                    fontFamily: AppFonts.poppinsLight
                )
            )
        )
  );

  _initPoints() {
    double xStart = 0;
    double xMiddle = width/2;
    double xEnd = width;
    double yStart = 0;
    double yEnd = height;
    double cornerXOffset = 7;
    double cornerYOffset = 13;
    double cornerRadius = 7;
    points.add(Offset(xMiddle, yStart)); //0 top small corner
    points.add(Offset(xMiddle + cornerXOffset, cornerYOffset)); //1 right small corner
    points.add(Offset(xEnd - cornerRadius, cornerYOffset)); //2 top right 1 corner
    points.add(Offset(xEnd, cornerYOffset)); //3 top right center corner
    points.add(Offset(xEnd, cornerYOffset + cornerRadius)); //4 top right 2 corner
    points.add(Offset(xEnd, yEnd - cornerRadius)); //5 bottom right 1 corner
    points.add(Offset(xEnd, yEnd)); //6 bottom right center corner
    points.add(Offset(xEnd - cornerRadius, yEnd)); //7 bottom right 2 corner
    points.add(Offset(xStart + cornerRadius, yEnd)); //8 bottom left 1 corner
    points.add(Offset(xStart, yEnd)); //9 bottom left center corner
    points.add(Offset(xStart, yEnd - cornerRadius)); //10 bottom left 2 corner
    points.add(Offset(xStart, cornerYOffset + cornerRadius)); //11 top left 1 corner
    points.add(Offset(xStart, cornerYOffset)); //12 top left center corner
    points.add(Offset(xStart + cornerXOffset, cornerYOffset)); //13 top left 2 corner
    points.add(Offset(xMiddle - cornerXOffset, cornerYOffset)); //14 left small corner
  }
}

class _StatusPainter extends CustomPainter {
  _StatusPainter(this._points) : super();

  final List<Offset> _points;

  @override
  void paint(Canvas canvas, Size size) {
    if (_points.isEmpty) return;
    Path path = Path();
    Offset offsetTopSmallCorner = _points[0];
    Offset offsetRightSmallCorner = _points[1];
    Offset offsetTopRight1Corner = _points[2];
    Offset offsetTopRightCenterCorner = _points[3];
    Offset offsetTopRight2Corner = _points[4];
    Offset offsetBottomRight1Corner = _points[5];
    Offset offsetBottomRightCenterCorner = _points[6];
    Offset offsetBottomRight2Corner = _points[7];
    Offset offsetBottomLeft1Corner = _points[8];
    Offset offsetBottomLeftCenterCorner = _points[9];
    Offset offsetBottomLeft2Corner = _points[10];
    Offset offsetTopLeft1Corner = _points[11];
    Offset offsetTopLeftCenterCorner = _points[12];
    Offset offsetTopLeft2Corner = _points[13];
    Offset offsetLeftSmallCorner = _points[14];
    path.moveTo(offsetTopSmallCorner.dx, offsetTopSmallCorner.dy);
    path.lineTo(offsetRightSmallCorner.dx, offsetRightSmallCorner.dy);
    path.lineTo(offsetTopRight1Corner.dx, offsetTopRight1Corner.dy);
    path.quadraticBezierTo(offsetTopRightCenterCorner.dx, offsetTopRightCenterCorner.dy, offsetTopRight2Corner.dx, offsetTopRight2Corner.dy);
    path.lineTo(offsetBottomRight1Corner.dx, offsetBottomRight1Corner.dy);
    path.quadraticBezierTo(offsetBottomRightCenterCorner.dx, offsetBottomRightCenterCorner.dy, offsetBottomRight2Corner.dx, offsetBottomRight2Corner.dy);
    path.lineTo(offsetBottomLeft1Corner.dx, offsetBottomLeft1Corner.dy);
    path.quadraticBezierTo(offsetBottomLeftCenterCorner.dx, offsetBottomLeftCenterCorner.dy, offsetBottomLeft2Corner.dx, offsetBottomLeft2Corner.dy);
    path.lineTo(offsetTopLeft1Corner.dx, offsetTopLeft1Corner.dy);
    path.quadraticBezierTo(offsetTopLeftCenterCorner.dx, offsetTopLeftCenterCorner.dy, offsetTopLeft2Corner.dx, offsetTopLeft2Corner.dy);
    path.lineTo(offsetLeftSmallCorner.dx, offsetLeftSmallCorner.dy);
    path.lineTo(offsetTopSmallCorner.dx, offsetTopSmallCorner.dy);
    canvas.drawPath(
      dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[7, 6])
      ),
      Paint()
        ..color = AppColors.colorStatusLine
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
    );
  }

  @override
  bool shouldRepaint(_StatusPainter oldDelegate) {
    return false;
  }
}