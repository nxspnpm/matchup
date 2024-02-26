import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool checked;
  final Function() onPressed;

  CustomButton({
    Key? key,
    required this.checked,
    required this.text,
    required this.onPressed,
  }) : super(
          key: key,
        ) {
    print('pim + ${checked}');
  }

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
                    checked ? 'Level 1 PASS' : 'Level:' + text,
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
    );
  }
}
