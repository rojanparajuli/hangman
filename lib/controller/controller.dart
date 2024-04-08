import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HangmanController extends GetxController {
  late String wordToGuess;
  late String guessedWord;
  int maxAttempts = 6;
  RxInt remainingAttempts = 6.obs;
  RxList<String> guessedLetters = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeGuessedWord();
  }

  void initializeGuessedWord() {
    List<Map<String, String>> wordList = [
      {"word": "FLUTTER", "hint": "my language"},
      {"word": "PRAYASH", "hint": "smart person"},
      {"word": "ROJAN", "hint": "garib"},
      {"word": "BISHAL", "hint": "google ceo"},
      {"word": "SANDESH", "hint": "gbl don"},
      {"word": "NITESH", "hint": "elon musk"},
      {"word": "PUSPHA", "hint": "non-veg"},
      {"word": "SUKHI", "hint": "singer"},
      {"word": "MOSAHID", "hint": "Katrina kalf"},
      {"word": "DIPESH", "hint": "Unmarried"},
      {"word": "SOVA", "hint": "billionaire"},
    ];

    final random = Random();
    final index = random.nextInt(wordList.length);
    wordToGuess = wordList[index]["word"]!;
    String hint = wordList[index]["hint"]!;

    guessedWord = "";
    for (int i = 0; i < wordToGuess.length; i++) {
      guessedWord += "_";
    }

    // Display the hint
    Get.dialog(
      AlertDialog(
        title: const Text('Hint'),
        content: Text(hint),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void guessLetter(String letter) {
    if (!guessedLetters.contains(letter)) {
      guessedLetters.add(letter);
      if (!wordToGuess.contains(letter)) {
        remainingAttempts--;
      } else {
        for (int i = 0; i < wordToGuess.length; i++) {
          if (wordToGuess[i] == letter) {
            guessedWord = guessedWord.substring(0, i) +
                letter +
                guessedWord.substring(i + 1);
          }
        }
      }
    }
  }

  void resetGame() {
    guessedLetters.clear();
    remainingAttempts.value = maxAttempts;
    initializeGuessedWord();
  }
}