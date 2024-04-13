// tik_tak_to_controller.dart
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  var board = List.filled(9, '').obs;
  var currentPlayer = 'X'.obs;
  var gameOver = false.obs;
  var singlePlayerMode = false.obs;
  var winner = ''.obs;
  var scoreX = 0.obs;
  var scoreO = 0.obs;
  final confettiController = ConfettiController();

  @override
  void onInit() {
    super.onInit();
    resetGame();
  }

  void resetGame() {
    board.value = List.filled(9, '');
    currentPlayer.value = 'X';
    gameOver.value = false;
    winner.value = '';
    scoreX.value = 0;
    scoreO.value = 0;
  }

  void playMove(int index) {
    if (!gameOver.value && board[index] == '') {
      board[index] = currentPlayer.value;
      _checkWinner();
      if (!gameOver.value && singlePlayerMode.value && currentPlayer.value == 'X') {
        _makeComputerMove();
      }
      currentPlayer.value = (currentPlayer.value == 'X') ? 'O' : 'X';
    }
  }

  void _makeComputerMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyCells.add(i);
      }
    }
    if (emptyCells.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyCells.length);
      playMove(emptyCells[randomIndex]);
    }
  }

  void _checkWinner() {
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' && board[i] == board[i + 1] && board[i] == board[i + 2]) {
        winner.value = board[i];
        _showWinnerDialog(board[i]);
        return;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] != '' && board[i] == board[i + 3] && board[i] == board[i + 6]) {
        winner.value = board[i];
        _showWinnerDialog(board[i]);
        return;
      }
    }

    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      winner.value = board[0];
      _showWinnerDialog(board[0]);
      return;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      winner.value = board[2];
      _showWinnerDialog(board[2]);
      return;
    }

    // Check for draw
    if (!board.contains('')) {
      _showDrawDialog();
      return;
    }
  }

  void _showWinnerDialog(String winner) {
    Get.dialog(
      AlertDialog(
        title: const Text('Game Over'),
        content: Text('Player $winner wins!'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              resetGame();
              Get.back();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
    if (winner == 'X') {
      scoreX++;
    } else {
      scoreO++;
    }
    confettiController.play();
    gameOver.value = true;
  }

  void _showDrawDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Game Over'),
        content: const Text('It\'s a draw!'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              resetGame();
              Get.back();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
    gameOver.value = true;
  }
}
