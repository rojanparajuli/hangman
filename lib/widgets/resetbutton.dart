// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class ResetButtonWidget extends StatelessWidget {
  final HangmanController hangmanController = Get.put(HangmanController());
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color?>(Colors.red.shade100),
  ),
  onPressed: () {
    hangmanController.resetGame();
  },
  child: const Text(
    'Reset Game',
    style: TextStyle(fontSize: 20),
  ),
);

  }
}
