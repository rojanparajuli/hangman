import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';
import 'package:hangman/widgets/albhabet_button.dart';
import 'package:hangman/widgets/guessword.dart';
import 'package:hangman/widgets/remaining_attemts.dart';
import 'package:hangman/widgets/resetbutton.dart';
import 'package:confetti/confetti.dart';

class HangmanPage extends StatelessWidget {
  final HangmanController hangmanController = Get.put(HangmanController());
  final ConfettiController confettiController = ConfettiController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        bool exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit Game?',
              style: TextStyle(
                color: Colors.red, 
                fontWeight: FontWeight.bold, 
                fontSize: 20.0, 
              ),
            ),
            content: const Text(
              'Are you sure you want to exit the Game?',
              style: TextStyle(
                fontSize: 18.0, 
              ),
            ),
            backgroundColor: Colors.white, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), 
              side: const BorderSide(color: Colors.blue, width: 2.0), 
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); 
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); 
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return exit;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Text('Score: ${hangmanController.score.value}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)),
                  const SizedBox(height: 10,),
                  const RemainingAttemptsWidget(),
                  GuessedWordWidget(),
                  const SizedBox(height: 100,),
                  AlphabetButtonsWidget(),
                  ResetButtonWidget(),
                ],
              ),
              Positioned.fill(
                child: Obx(() {
                  if (hangmanController.guessedWord.value == hangmanController.wordToGuess.value) {
                    confettiController.play();
                    return ConfettiWidget(
                      confettiController: confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true,
                      colors: const [Colors.blue, Colors.red, Colors.green],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
