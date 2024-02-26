import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:matchup/screens/easy.dart';
import 'package:matchup/screens/hard.dart';
import 'package:matchup/screens/normal.dart';
import 'package:matchup/widgets/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelGame extends StatefulWidget {
  const LevelGame({super.key});

  @override
  State<LevelGame> createState() => _LevelGameState();
}

class _LevelGameState extends State<LevelGame> {
  late SharedPreferences prefs;
  late Map<String, dynamic> storedProfile = {};

  late List<Map<String, dynamic>> menuLevel = [
    {
      'level_name': 'Easy Game',
      'text': '1',
      'succuess': false,
      'onPressed': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EasyLavel()),
        );
      },
    },
    {
      'level_name': 'Normal Game',
      'text': '2',
      'success': false,
      'onPressed': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Normal()),
        );
      },
    },
    {
      'level_name': 'Hard Game',
      'text': '3',
      'success': false,
      'onPressed': () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Hard()),
        );
      },
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    final String? profileJsonFromPrefs = prefs.getString('profile');
    if (profileJsonFromPrefs != null) {
      setState(() {
        storedProfile = jsonDecode(profileJsonFromPrefs);
      });
      print(storedProfile['level']?[0]);
      print('testtststta');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text('Level'),
      // ),

      body: Container(
        color: Colors.white, // สีพื้นหลังขาว
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 3,
                colors: [
                  Color.fromARGB(255, 160, 50, 250),
                  const Color.fromARGB(255, 41, 64, 194),
                ],
                stops: [0.1, 0.9],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < menuLevel.length; index++)
                    //CustomButton(
                    //  key: ValueKey(index),
                    //  text: menuLevel[index]['text'],
                    //  checked:
                    //      storedProfile['level']?[index]?['pass'].toString() ==
                    //              'true'
                    //          ? true
                    //          : false,
                    //  onPressed: menuLevel[index]['onPressed'],
                    //),
                    GestureDetector(
                      onTap: menuLevel[index]['onPressed'],
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Stack(
                              key: ValueKey(index),
                              children: [
                                // Text('pimmmmmm' + checked.toString()),
                                Image.asset(
                                  'assets/images/card_bg.png',
                                  height: 430,
                                  width: 450,
                                ),
                                Positioned(
                                  top: 40,
                                  left: 130,
                                  child: Text(
                                    storedProfile['level']?[index]?['pass']
                                                .toString() ==
                                            'true'
                                        ? 'Level Pass'
                                        : 'Level : + ${index + 1}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
