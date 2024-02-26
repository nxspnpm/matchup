import 'package:flutter/material.dart';
import 'package:matchup/screens/level.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  late SharedPreferences prefs;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? validateUsername(value) {
    if (value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgLogin.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40),
                  child: TextFormField(
                    controller: userName,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white38,
                      hintText: 'Your Username',
                      prefixIcon: Icon(Icons.face),
                      prefixIconColor: Colors.white,
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 2,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                    validator: validateUsername,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    if (validateUsername(userName.text) == null) {
                      //map แล้วแทนค่าใส่ใน profile
                      final Map<String, dynamic> profile = {
                        "name": userName.text,
                        "level": [
                          {
                            "level": 1,
                            "pass": false,
                          },
                          {
                            "level": 2,
                            "pass": false,
                          },
                          {
                            "level": 3,
                            "pass": false,
                          },
                          {
                            "level": 4,
                            "pass": false,
                          }
                        ],
                      };
                      final String profileJson = jsonEncode(profile);
                      prefs.setString('profile', profileJson);

                      //get profile from shared preferences
                      final String? profileJsonFromPrefs =
                          prefs.getString('profile');
                      if (profileJsonFromPrefs != null) {
                        final Map<String, dynamic> storedProfile =
                            jsonDecode(profileJsonFromPrefs);
                        print(storedProfile);
                      } else {
                        print("Profile not found in shared preferences.");
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LevelGame()),
                      );
                    }
                  },
                  child: Text('Login',
                      style: TextStyle(fontSize: 15, color: Colors.grey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
