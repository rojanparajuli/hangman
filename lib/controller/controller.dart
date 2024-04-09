import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HangmanController extends GetxController {
  late RxString wordToGuess;
  late RxString guessedWord;
  int maxAttempts = 6;
  late RxInt remainingAttempts;
  late RxInt score; 
  RxList<String> guessedLetters = <String>[].obs;
  late RxString hint;
  late ConfettiController confettiController;

  // Define scoreKey as a static constant
  static const String scoreKey = 'hangman_score';

  @override
  void onInit() {
    super.onInit();
    wordToGuess = ''.obs;
    guessedWord = ''.obs;
    remainingAttempts = 6.obs;
    confettiController = ConfettiController();
    initializeGuessedWord();
    loadScore();
    Future.delayed(const Duration(seconds: 2), () {
      return showDialogss();
    });
  }

  Future<void> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    score = RxInt(prefs.getInt(scoreKey) ?? 0);
  }

  Future<void> saveScoreToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(scoreKey, score.value);
  }

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

  void initializeGuessedWord() {
    final random = Random();
    final index = random.nextInt(wordList.length);
    wordToGuess.value = wordList[index]["word"]!;
    hint = wordList[index]["hint"]!.obs;

    for (int i = 0; i < wordToGuess.value.length; i++) {
      guessedWord.value += "_";
    }
  }

  void showDialogss() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hint'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(hint.value),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void guessLetter(String letter) {
    guessedLetters.add(letter);
    if (!wordToGuess.contains(letter)) {
      if (remainingAttempts.value > 0) {
        --remainingAttempts.value;
        if (remainingAttempts.value == 0) {
          showAttemptsOverDialog();
        }
      }
    } else {
      for (int i = 0; i < wordToGuess.value.length; i++) {
        if (wordToGuess.value[i] == letter) {
          guessedWord.value = guessedWord.value.substring(0, i) +
              letter +
              guessedWord.value.substring(i + 1);

          guessedLetters.refresh();
        }
      }
      if (guessedWord.value == wordToGuess.value) {
        updateScore(10); 
        showCongratulationDialog();
      }
    }
  }

  void updateScore(int value) {
    score.value += value;
    saveScoreToPrefs();
  }

  void showAttemptsOverDialog() {
    updateScore(-10); 
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('Your attempts are over. Do you want to try again?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                resetGame();
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void showCongratulationDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You have guessed the right answer.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                confettiController.play(); // Start confetti animation
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    guessedLetters.value = [];
    guessedLetters.refresh();
    guessedWord.value = '';
    remainingAttempts.value = maxAttempts;
    initializeGuessedWord();
    showDialogss();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}
