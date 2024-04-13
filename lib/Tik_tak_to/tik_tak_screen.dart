import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/Tik_tak_to/tik_tak.controller.dart';

class TiktakScreen extends StatelessWidget {
  final controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade100,
      ),
      body: Obx(
        () => Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => controller.playMove(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              controller.board[index],
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: controller.board[index] == 'X'
                                    ? Colors.blue
                                    : controller.board[index] == 'O'
                                        ? Colors.red
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(Colors.red.shade100),
                      ),
                      onPressed: () {
                        controller.resetGame();
                      },
                      child: const Text('Reset Game'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(Colors.red.shade100),
                      ),
                      onPressed: () {
                        controller.currentPlayer.value = 'X';
                      },
                      child: const Text('Choose X'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(Colors.red.shade100),
                      ),
                      onPressed: () {
                        controller.currentPlayer.value = 'O';
                      },
                      child: const Text('Choose O'),
                    ),
                  ],
                ),
              ],
            ),
            // ignore: unnecessary_null_comparison
            if (controller.gameOver.value && controller.winner.value != null)
              Positioned(
                top: 20,
                left: 20,
                child: ConfettiWidget(
                  confettiController: controller.confettiController,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.05,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
