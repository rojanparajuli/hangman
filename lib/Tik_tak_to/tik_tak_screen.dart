// tiktak_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/Tik_tak_to/tik_tak.controller.dart';
import 'package:confetti/confetti.dart';

class TiktakScreen extends StatelessWidget {
  final controller = Get.put(GameController());

  TiktakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade100,
      ),
      body: SingleChildScrollView(
        child: Obx(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color?>(
                              Colors.red.shade100),
                        ),
                        onPressed: () {
                          controller.resetGame();
                        },
                        child: const Text('Reset Game'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color?>(
                              Colors.red.shade100),
                        ),
                        onPressed: () {
                          controller.currentPlayer.value = 'X';
                        },
                        child: const Text('Choose X'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color?>(
                              Colors.red.shade100),
                        ),
                        onPressed: () {
                          controller.currentPlayer.value = 'O';
                        },
                        child: const Text('Choose O'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Score X:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Obx(() => Text(
                                  '${controller.scoreX}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50,
                                      color: Colors.blue),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Score O:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Obx(() => Text(
                                  '${controller.scoreO}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50,
                                      color: Colors.red),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (controller.gameOver.value)
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
      ),
    );
  }
}
