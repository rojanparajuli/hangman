import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class ResetButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.find<HangmanController>().resetGame();
      },
      child: const Text(
        'Reset Game',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
