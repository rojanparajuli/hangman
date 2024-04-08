import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class GuessedWordWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<HangmanController>(
      init: HangmanController(),
      builder: (hangmanController) {
        return Text(
          hangmanController.guessedWord,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
