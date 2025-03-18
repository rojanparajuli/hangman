import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/screen/splashscreen.dart';

void main() {
  runApp(const HangmanGame());
}

class HangmanGame extends StatelessWidget {
  const HangmanGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const SplashScreen(),
    );
  }
}


