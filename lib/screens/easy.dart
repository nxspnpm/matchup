import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchup/screens/controller.dart';
import 'package:matchup/screens/level.dart';
import 'package:matchup/widgets/dsilog.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EasyLavel extends StatefulWidget {
  @override
  _EasyLavelState createState() => _EasyLavelState();
}

class _EasyLavelState extends State<EasyLavel> {
  late SharedPreferences prefs;
  final Controller controller = Get.put(Controller());
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  final CountdownController _controllerw =
      new CountdownController(autoStart: false);

  int countdownSeconds = 10;
  bool showAlert = true;

  void _startCountdown() {
    _controllerw.start();
  }

  void _stopCountdown() {
    _controllerw.pause();
  }

  @override
  void initState() {
    super.initState();
    controller.initializeGame();
    initializePrefs();

    Future.delayed(Duration.zero).then((_) {
      showCustomDialog();
    });
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Level :  1',
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
                  padding: EdgeInsets.all(28.0),
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
                                    barrierDismissible: false,
                                    context: context,
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
                                                    controller.initializeGame();
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
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
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
                                                              _startCountdown();
                                                              _controllerw
                                                                  .restart();
                                                              controller
                                                                  .initializeGame();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                                'Play Again',
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
                                                                        'level'][0]
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
                                                              } else {
                                                                print(
                                                                    "Profile not found in shared preferences.");
                                                              }
                                                            },
                                                            child: Text(
                                                                'Naxt Page',
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
                              elevation:
                                  5, // Adjust the elevation for the shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the border radius as needed
                              ),
                              color: Colors.pink[300],

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
                  Navigator.of(context, rootNavigator: true).pop();
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
