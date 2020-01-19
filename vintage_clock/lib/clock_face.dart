import 'package:flutter/material.dart';
import 'clock_hands.dart';
import 'clock_dial_painter.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;
  final ClockText clockText;

  ClockFace({this.clockText = ClockText.arabic, this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
//            Colors.orange.shade200,Colors.deepOrange.shade400,
            Color(0xFF7BE495),
            Color(0xFF329D9C),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new AspectRatio(
          aspectRatio: 1.0,
          child: new Stack(
            children: <Widget>[
              //dial and numbers go here
              new Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(0.0),
                child: new CustomPaint(
                  painter: new ClockDialPainter(clockText: clockText),
                ),
              ),
              //centerpoint
              new Center(
                child: new Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              new ClockHands(),
              //clock hands go here
            ],
          ),
        ),
      ),
    );
  }
}
