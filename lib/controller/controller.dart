import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HangmanController extends GetxController {
  late RxString wordToGuess;
  late RxString guessedWord;
  int maxAttempts = 6;
  late RxInt remainingAttempts;
  late RxInt score;
  RxList<String> guessedLetters = <String>[].obs;
  late RxString hint;
  late ConfettiController confettiController;
  Timer? timer;

  static const String scoreKey = 'hangman_score';
  List<Map<String, dynamic>> map = [];

  @override
  void onInit() {
    super.onInit();
    getPostAPi();
    wordToGuess = ''.obs;
    guessedWord = ''.obs;
    remainingAttempts = 6.obs;
    hint = ''.obs;
    confettiController = ConfettiController();
    timer = Timer(const Duration(seconds: 30), () {
      showTryAgainDialog();
    });
    Future.delayed(const Duration(seconds: 5), () {
      return initializeGuessedWord();
    });

    loadScore();
    Future.delayed(const Duration(seconds: 5), () {
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

  Future getPostAPi() async {
    final response =
        await http.get(Uri.parse('https://rojanparajuli.com.np/game.json'));
    print(response.body);

    if (response.statusCode == 200) {
      return map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  void initializeGuessedWord() {
    final random = Random();
    final index = random.nextInt(map.length);
    wordToGuess.value = map[index]["word"];
    hint.value = map[index]["hint"];

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
    // Check if the game is already over
    if (remainingAttempts.value == 0 || guessedWord.value == wordToGuess.value) {
      showAttemptsOverDialog();
      return;
    }

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
    resetTimer(); // Reset the timer after each guess
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
          content:
               Text('Your attempts are over. Right answer is $wordToGuess'),
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
          content:  Text(' $wordToGuess is right answer.'),
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

  void showTryAgainDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Time\'s Up!'),
          content:  Text('You took too long to guess. $wordToGuess is correct answer'),
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

  void resetGame() {
    guessedLetters.value = [];
    guessedLetters.refresh();
    guessedWord.value = '';
    remainingAttempts.value = maxAttempts;
    initializeGuessedWord();
    showDialogss();
    resetTimer(); // Reset the timer when resetting the game
  }

  void resetTimer() {
    timer?.cancel(); // Cancel the previous timer if running
    timer = Timer(const Duration(seconds: 30), () {
      showTryAgainDialog();
    });
  }

  @override
  void onClose() {
    confettiController.dispose();
    timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}

class PostModal {}