// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'clock_dial_painter.dart';
import 'clock_face.dart';

typedef TimeProducer = DateTime Function();

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  final ClockModel model;
  final ClockText clockText;
  final TimeProducer getCurrentTime;
  final Duration updateDuration;

  const AnalogClock(
      {this.model,
      this.clockText = ClockText.arabic,
      this.getCurrentTime = getSystemTime,
      this.updateDuration = const Duration(seconds: 1)});

  static DateTime getSystemTime() {
    return new DateTime.now();
  }

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  Timer _timer;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.6,
        child: new Stack(alignment: Alignment.center, children: <Widget>[
          new Container(
            //color: Colors.black,
            width: 350,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 6,
                  color: Colors.grey.shade700,
                )),
            child: new ClockFace(
              clockText: widget.clockText,
              dateTime: dateTime,
            ),
          ),
        ]));
  }
}
