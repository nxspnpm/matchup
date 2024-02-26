import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';

class Countdown extends StatefulWidget {
  final CountdownController controller;
  final int seconds;
  final Function onFinished;

  Countdown({
    required this.controller,
    required this.seconds,
    required this.onFinished,
    required Duration interval,
    required Text Function(dynamic _, double time) build,
  });

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      controller: widget.controller,
      seconds: widget.seconds,
      build: (_, double time) => Text(
        time.toString(),
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      interval: Duration(milliseconds: 100),
      onFinished: widget.onFinished,
    );
  }
}
