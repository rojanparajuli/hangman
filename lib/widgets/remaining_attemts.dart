import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class RemainingAttemptsWidget extends StatelessWidget {
  const RemainingAttemptsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HangmanController>(
      init: HangmanController(),
      builder: (hangmanController) {
        return Center(
          child: Text(
            'Remaining Attempts: ${hangmanController.remainingAttempts},',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}