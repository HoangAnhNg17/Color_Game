import 'dart:ui';
import 'package:color_game/pages/setting_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../bloc/gameplay.dart';

// Future<bool?> showEndGameDialog(
//     {required BuildContext context, required GamePlay gamePlay}) {
//   return showGeneralDialog<bool>(
//     context: context,
//     barrierDismissible: false,
//     barrierLabel: '',
//     barrierColor: Colors.black54,
//     transitionDuration: const Duration(milliseconds: 500),
//     transitionBuilder: (BuildContext context, Animation first, Animation second,
//         Widget child) {
//       final curvedValue = Curves.easeInOutBack.transform(first.value) - 1.0;
//       return Transform(
//         transform: Matrix4.translationValues(0, curvedValue * 200, 0),
//         child: child,
//       );
//     },
//     pageBuilder: (context, animation1, animation2) => BackdropFilter(
//       filter: ImageFilter.blur(
//         sigmaX: 5,
//         sigmaY: 5,
//       ),
//       child: Dialog(
//         backgroundColor: Colors.blueAccent.withOpacity(0.5),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//           side: const BorderSide(
//             color: Colors.blueAccent,
//             width: 3,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Lottie.asset('assets/lottie/game-over.json', height: 399),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text('Your score is : ${gamePlay.level.value}', style: TextStyle(color: Colors.white),),
//                   SizedBox(height: 20,),
//                   ElevatedButton(
//                     onPressed: () {
//                       Get.back();
//                       gamePlay.restart();
//                     },
//                     child: const Text('New Game'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ).then((value) {
//     if (value == null) {
//       gamePlay.pauseGame.value = false;
//     } else {
//       return;
//     }
//   });
// }


class GameWonOverlay extends StatelessWidget {
  const GameWonOverlay({Key? key, required this.context, required this.gamePlay, })
      : super(key: key);

  final BuildContext context;
  final GamePlay gamePlay;


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      width: _size.width,
      color: Colors.black.withOpacity(0.8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/game-won.json'),
          ],
        ),
      ),
    );
  }
}
