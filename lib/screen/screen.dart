import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/Tik_tak_to/loading.dart';
import 'package:hangman/controller/controller.dart';
import 'package:hangman/widgets/albhabet_button.dart';
import 'package:hangman/widgets/guessword.dart';
import 'package:hangman/widgets/remaining_attemts.dart';
import 'package:hangman/widgets/resetbutton.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: must_be_immutable
class HangmanPage extends StatelessWidget {
  HangmanPage({super.key});

  final HangmanController hangmanController = Get.put(HangmanController());

  final ConfettiController confettiController = ConfettiController();

  final AudioPlayer audioPlayer = AudioPlayer();

  bool isHintPressed = false;
  bool ispaused = false;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
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
              side: const BorderSide(color: Colors.white, width: 2.0),
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
        appBar: AppBar(
          actions: [
            Center(
              child: IconButton(
                onPressed: () {
                  isHintPressed = true;
                  hangmanController.showDialogss();
                },
                icon: Center(
                  child: Icon(
                    isHintPressed ? Icons.lightbulb : Icons.lightbulb_rounded,
                    color: Colors.amber,
                  ),
                ),
                highlightColor: Colors.transparent,
              ),
            ),
            Center(
                child: IconButton(
              onPressed:() {
                Get.to(TictacsplashScreen());
              },
              icon: Icon(
                Icons.settings,
                color: Colors.red.shade100,
              ),
            )),
            IconButton(
              onPressed: () {
                hangmanController.toggleGamePause();
              },
              icon: Icon(
                hangmanController.isGamePaused ? Icons.play_arrow : Icons.pause,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Text(
                        'Score: ${hangmanController.score.value}',
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const RemainingAttemptsWidget(),
                  GuessedWordWidget(),
                  const SizedBox(
                    height: 100,
                  ),
                  AlphabetButtonsWidget(),
                  ResetButtonWidget(),
                ],
              ),
              Positioned.fill(
                child: Obx(() {
                  if (hangmanController.guessedWord.value ==
                      hangmanController.wordToGuess.value) {
                    confettiController.play();
                    hangmanController.playAudio('audio/clapaudio.mp3');
                    return ConfettiWidget(
                      confettiController: confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true,
                      colors: const [Colors.blue, Colors.red, Colors.green],
                    );
                  } else if (hangmanController.remainingAttempts.value == 0) {
                    hangmanController.playAudio('audio/booaudio.mp3');
                  }
                  return const SizedBox.shrink();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
