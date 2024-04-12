import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman/controller/controller.dart';

class AlphabetButtonsWidget extends StatelessWidget {
  final List<String> keyboardLayout = [
    'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L',
    'Z', 'X', 'C', 'V', 'B', 'N', 'M'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          // childAspectRatio: 1
        ),
        itemCount: keyboardLayout.length + 1, 
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == keyboardLayout.length) {
            return SpaceButtonWidget();
          } else {
            String letter = keyboardLayout[index];
            return GestureDetector(
              onTap: (){
                Get.find<HangmanController>().guessLetter(letter);
              },
              child: CircleAvatar(
                backgroundColor: Colors.red[50],
                child:Text(
                    
                    letter,
                    style: const TextStyle(fontSize: 20),
                  ), ),
            )
            //  ElevatedButton(
            //   onPressed: () {
            //     Get.find<HangmanController>().guessLetter(letter);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 40, ),
            //     child: Text(
                  
            //       letter,
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ),
            // )
            ;
          }
        },
      ),
    );
  }
}

class SpaceButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: (){
                 Get.find<HangmanController>().guessLetter(' ');
              },
              child: CircleAvatar(
                backgroundColor: Colors.red[50],
                child:Icon(Icons.space_bar), ),
            );
    
    
    // ElevatedButton(
    //   onPressed: () {
    //     Get.find<HangmanController>().guessLetter(' ');
    //   },
    //   child: const Center(
    //     child: Icon(Icons.space_bar),
    //   ),
    // );
  }
}
