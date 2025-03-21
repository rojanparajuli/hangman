import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/screen/screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 2), () {
      Get.off( HangmanPage()); 
    });

    return  Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 
            Lottie.asset('assets/animation.json'),
            const SizedBox(height: 20),
            const Text(
              'Slap Words',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
