import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class AlphabetButtonsWidget extends StatelessWidget {
  final List<String> keyboardLayout = [
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
    'Z', 'X', 'C', 'V', 'B', 'N', 'M'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: keyboardLayout.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String letter = keyboardLayout[index];
          return ElevatedButton(
            onPressed: () {
              Get.find<HangmanController>().guessLetter(letter);
            },
            child: Text(
              letter,
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
