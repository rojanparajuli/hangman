import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class GuessedWordWidget extends StatelessWidget {
  final HangmanController hangmanController = Get.put(HangmanController());

  GuessedWordWidget({super.key});
  @override
  Widget build(BuildContext context) {
        return Obx(()=> Center(
          child: Text(hangmanController.guessedWord.value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
        ),
        );
  }
}
