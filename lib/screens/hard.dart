import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchup/screens/controller.dart';
import 'package:matchup/screens/level.dart';
import 'package:matchup/widgets/dsilog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Hard extends StatefulWidget {
  @override
  _HardState createState() => _HardState();
}

class _HardState extends State<Hard> {
  final Controller controller = Get.put(Controller());
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  final CountdownController _controllerw =
      new CountdownController(autoStart: false);
  late SharedPreferences prefs;

  int countdownSeconds = 120;
  bool showAlert = true;

  void _startCountdown() {
    _controllerw.start();
  }

  void _stopCountdown() {
    _controllerw.pause();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePrefs();
    controller.initializeGameHard();
    Future.delayed(Duration.zero, () {
      showCustomDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Level :  3',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            ),
            color: Colors.white,
            onPressed: () {
              _stopCountdown();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Obx(
              () {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 120,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black87,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black87,
                            ),
                            child: Row(children: [
                              const Icon(
                                Icons.access_alarm,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Countdown(
                                controller: _controllerw,
                                seconds: countdownSeconds,
                                build: (_, double time) => Text(
                                  time.toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                interval: Duration(milliseconds: 100),
                                onFinished: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                            'Time Out',
                                            textAlign: TextAlign.center,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          insetPadding: EdgeInsets.all(0.0),
                                          backgroundColor: Colors.white,
                                          elevation: 4,
                                          surfaceTintColor: Colors.transparent,
                                          actions: [
                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Black',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black)),
                                                ),
                                                Spacer(),
                                                TextButton(
                                                  onPressed: () {
                                                    controller
                                                        .initializeGameHard();
                                                    Navigator.of(context).pop();
                                                    Future.delayed(
                                                        Duration.zero, () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                              title: Center(
                                                                child:
                                                                    Countdown(
                                                                  controller:
                                                                      _controller,
                                                                  seconds: 3,
                                                                  build: (_,
                                                                          double
                                                                              time) =>
                                                                      Text(
                                                                    time
                                                                        .toInt()
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            48,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  onFinished:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    _startCountdown();
                                                                    _controllerw
                                                                        .restart();
                                                                  },
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              elevation: 0,
                                                              surfaceTintColor:
                                                                  Colors
                                                                      .transparent);
                                                        },
                                                      );
                                                    });
                                                  },
                                                  child: Text('Restart',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            )
                                          ]);
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                width: 4,
                              )
                            ]),
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemCount: controller.board.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller
                                  .handleCardTap(context, index)
                                  .then((value) => {
                                        if (value)
                                          {
                                            _stopCountdown(),
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text(
                                                      'You Win !',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 4,
                                                    surfaceTintColor:
                                                        Colors.transparent,
                                                    actions: [
                                                      ButtonBar(
                                                        alignment: MainAxisAlignment
                                                            .center, // Center the buttons
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              _controllerw
                                                                  .restart();
                                                              controller
                                                                  .initializeGame();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                                'Play again',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              controller
                                                                  .initializeGame();

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              final String?
                                                                  profileJsonFromPrefs =
                                                                  prefs.getString(
                                                                      'profile');
                                                              if (profileJsonFromPrefs !=
                                                                  null) {
                                                                final Map<
                                                                        String,
                                                                        dynamic>
                                                                    storedProfile =
                                                                    jsonDecode(
                                                                        profileJsonFromPrefs);
                                                                print(
                                                                    storedProfile);
                                                                storedProfile[
                                                                        'level'][1]
                                                                    [
                                                                    'pass'] = true;

                                                                final Map<
                                                                        String,
                                                                        dynamic>
                                                                    profile = {
                                                                  "name":
                                                                      storedProfile[
                                                                          'name'],
                                                                  "level":
                                                                      storedProfile[
                                                                          'level'],
                                                                };
                                                                final String
                                                                    profileJson =
                                                                    jsonEncode(
                                                                        profile);
                                                                prefs.setString(
                                                                    'profile',
                                                                    profileJson);
                                                                print(profile);
                                                              }
                                                            },
                                                            child: Text(
                                                                'Next Level',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                        ],
                                                      )
                                                    ]);
                                              },
                                            )
                                          }
                                      });
                            },
                            child: Card(
                              color: Colors.green,
                              child: Center(
                                child: controller.board[index] != ''
                                    ? Image.asset(
                                        controller.board[index],
                                        fit: BoxFit.cover,
                                      )
                                    : Text(
                                        '',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  void showCustomDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(
              child: Countdown(
                controller: _controller,
                seconds: 3,
                build: (_, double time) => Text(
                  time.toInt().toString(),
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                onFinished: () {
                  Navigator.of(context).pop();
                  _startCountdown();
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent);
      },
    );
  }
}
