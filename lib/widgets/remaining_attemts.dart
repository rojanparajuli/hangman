import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class RemainingAttemptsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<HangmanController>(
      init: HangmanController(),
      builder: (hangmanController) {
        return Text(
          'Remaining Attempts: ${hangmanController.remainingAttempts}',
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}