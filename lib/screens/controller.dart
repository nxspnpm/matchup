import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matchup/screens/easy.dart';
import 'package:matchup/screens/hard.dart';
import 'package:matchup/screens/normal.dart';

class Controller extends GetxController {
  List<String> imagePaths = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/1.png',
    'assets/images/2.png',
  ];

  List<String> imageNormal = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
  ];

  List<String> imageHard = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
    'assets/images/9.png',
    'assets/images/10.png',
    'assets/images/11.png',
    'assets/images/12.png',
    'assets/images/13.png',
    'assets/images/14.png',
    'assets/images/15.png',
    'assets/images/16.png',
    'assets/images/17.png',
    'assets/images/18.png',
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
    'assets/images/9.png',
    'assets/images/10.png',
    'assets/images/11.png',
    'assets/images/12.png',
    'assets/images/13.png',
    'assets/images/14.png',
    'assets/images/15.png',
    'assets/images/16.png',
    'assets/images/17.png',
    'assets/images/18.png',
  ];

  RxList shuffledCards = [].obs;
  RxList board = [].obs;

  RxList selectedIndices = [].obs;
  List<String> checkBordCardOpen = [];

  void initializeGame() {
    board.value = [].obs;
    shuffledCards.value = shuffle(imagePaths);
    board.value = List.filled(imagePaths.length, '');
  }

  List<String> shuffle(List<String> imagePaths) {
    List<String> shuffledCards = List.from(imagePaths);
    shuffledCards.shuffle();
    return shuffledCards;
  }

  //normal
  void initializeGameNormal() {
    board.value = [].obs;
    shuffledCards.value = shuffle(imageNormal);
    board.value = List.filled(imageNormal.length, '');
  }

  List<String> shuffleNormal(List<String> imageNormal) {
    List<String> shuffledCards = List.from(imageNormal);
    shuffledCards.shuffle();
    return shuffledCards;
  }

  //hard
  void initializeGameHard() {
    board.value = [].obs;
    shuffledCards.value = shuffle(imageHard);
    board.value = List.filled(imageHard.length, '');
  }

  List<String> shuffleHard(List<String> imageHard) {
    List<String> shuffledCards = List.from(imageHard);
    shuffledCards.shuffle();
    return shuffledCards;
  }

  void resetGame() {
    initializeGame();
    // initializeGameNormal(2);
    // initializeGameNormal(3);

    selectedIndices.clear();
  }

  Future handleCardTap(
    BuildContext context,
    int index,
    // int level,
  ) async {
    if (selectedIndices.length < 2 && board[index] == '') {
      selectedIndices.add(index);
      board[index] = shuffledCards[index];

      if (selectedIndices.length == 2) {
        if (shuffledCards[selectedIndices[0]] !=
            shuffledCards[selectedIndices[1]]) {
          Future.delayed(Duration(seconds: 1), () {
            board[selectedIndices[0]] = '';
            board[selectedIndices[1]] = '';
            selectedIndices.clear();
          });
        } else {
          selectedIndices.clear();
        }
      }

      List<dynamic> checkBordCardOpen =
          board.where((element) => element.isNotEmpty).toList();
      if (checkBordCardOpen.length == board.length) {
        return true;
        
      } else {
        return false;
      }
    }
  }
}
