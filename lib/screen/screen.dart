
import 'package:flutter/material.dart';
import 'package:hangman/widgets/albhabet_button.dart';
import 'package:hangman/widgets/guessword.dart';
import 'package:hangman/widgets/remaining_attemts.dart';
import 'package:hangman/widgets/resetbutton.dart';

class HangmanPage extends StatelessWidget {
  const HangmanPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RemainingAttemptsWidget(),
            GuessedWordWidget(),
            AlphabetButtonsWidget(),
            ResetButtonWidget(),
          ],
        ),
      ),
    );
  }
}