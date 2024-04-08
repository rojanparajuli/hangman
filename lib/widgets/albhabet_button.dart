import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class AlphabetButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      children: List.generate(26, (index) {
        String letter = String.fromCharCode('A'.codeUnitAt(0) + index);
        return ElevatedButton(
          onPressed: () {
            Get.find<HangmanController>().guessLetter(letter);
          },
          child: Text(
            letter,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }),
    );
  }
}