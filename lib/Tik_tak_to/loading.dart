import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/Tik_tak_to/tik_tak_screen.dart';
import 'package:lottie/lottie.dart';

class TictacsplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    Future.delayed(const Duration(seconds: 6), () {
      Get.off( TiktakScreen()); 
    });

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 
            Lottie.asset('assets/tictac animation.json'),
            const SizedBox(height: 20),
            const Text(
              'Slap Words',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
