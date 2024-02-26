import 'package:flutter/material.dart';
import 'package:matchup/widgets/countdown.dart';
import 'package:timer_count_down/timer_controller.dart';

class DialogCount extends StatefulWidget {
  const DialogCount({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogCount> createState() => DialogCountState();
}

class DialogCountState extends State<DialogCount> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  bool isChecked = false;

  dialogContent(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    return Container(
      width: 310,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // To make the card compact
              children: <Widget>[
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Countdown(
                                controller: _controller,
                                seconds: 3,
                                build: (_, double time) => Text(
                                  time.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                interval: Duration(milliseconds: 100),
                                onFinished: () {
                                  // _startCountdown();
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: mQ.width*0.08,),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mQ.height * 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding:
          const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 30.0),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
