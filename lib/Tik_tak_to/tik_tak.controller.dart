import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_confetti/flutter_confetti.dart';

class GameController extends GetxController {
  var board = List.filled(9, '').obs;
  var currentPlayer = 'X'.obs;
  var gameOver = false.obs;
  var singlePlayerMode = false.obs; // Indicates whether the game is in single-player mode

  final confettiController = ConfettiController(); // Controller for confetti animation

  void resetGame() {
    board.value = List.filled(9, '');
    currentPlayer.value = 'X';
    gameOver.value = false;
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
    // Find empty cells
    List<int> emptyCells = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptyCells.add(i);
      }
    }
    // Choose a random empty cell
    if (emptyCells.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyCells.length);
      playMove(emptyCells[randomIndex]);
    }
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' && board[i] == board[i + 1] && board[i] == board[i + 2]) {
        _showWinnerDialog(board[i]);
        return;
      }
    }
    
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' && board[i] == board[i + 3] && board[i] == board[i + 6]) {
        _showWinnerDialog(board[i]);
        return;
      }
    }
    
    // Check diagonals
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      _showWinnerDialog(board[0]);
      return;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
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
