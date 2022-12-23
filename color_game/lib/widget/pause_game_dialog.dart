import 'dart:ui';
import 'package:color_game/pages/setting_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../bloc/gameplay.dart';

Future<bool?> showPauseGameDialog(
    {required BuildContext context, required GamePlay gamePlay}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (BuildContext context, Animation first, Animation second,
        Widget child) {
      final curvedValue = Curves.easeInOutBack.transform(first.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0, curvedValue * 200, 0),
        child: child,
      );
    },
    pageBuilder: (context, animation1, animation2) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Dialog(
        backgroundColor: Colors.pinkAccent.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Colors.pinkAccent,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'Game Paused',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.to(()=> SettingPage());
                    },
                    icon: Icon(Icons.settings, color: Colors.white,),
                  )
                ],
              ),
              Lottie.asset('assets/lottie/game-paused.json'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      gamePlay.pause();
                      Get.back();
                    },
                    child: const Text('Resume Game'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      gamePlay.restart();
                    },
                    child: const Text('New Game'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ).then((value) {
    if (value == null) {
      gamePlay.pauseGame.value = false;
    } else {
      return;
    }
  });
}
