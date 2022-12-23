import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:color_game/widget/new_high_score_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/end_game_dialog.dart';
import 'audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GamePlay extends GetxController {

  SharedPreferences? sharedPreferences;

  RxInt level = 1.obs, crossAxisCount = 2.obs;
  RxInt diffIndex = 0.obs;
  RxBool gameOver = false.obs;
  RxDouble second = 60.00.obs;
  RxInt color = 0.obs;
  RxInt diffColor = 0.obs;
  RxDouble bonus = 0.0.obs;
  RxBool pauseGame = false.obs;
  RxBool show = false.obs;
  RxInt bonusStar = 0.obs;
  RxDouble sumBonus = 0.0.obs;
  RxBool showStar = false.obs;
  RxInt highScore = 0.obs;
  RxBool getHighScore = false.obs;

  late BuildContext context;


  Future saveDataFromLocal() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    int data = level.value;
    await sharedPreferences!.setInt('highScore', data);
  }

  void getDataFromLocal() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    highScore.value = sharedPreferences!.getInt('highScore')!;
  }

  void updateData() {
    final rand = Random();
    final cAC = min(10, ((level.value + 9) / 5).floor());
    final diff = rand.nextInt(cAC * cAC);
    final co = Color.fromRGBO(
        rand.nextInt(255), rand.nextInt(255), rand.nextInt(255), 1);
    final diffCo = co.withOpacity(min(0.95, 0.5 + (level.value / 50)));

    showStar.value = false;
    diffIndex.value = diff;
    color.value = co.value;
    diffColor.value = diffCo.value;
    crossAxisCount.value = cAC;
  }

  void setTimer() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (pauseGame.value) {
        timer.cancel();
      }
      if (second > 0.01) {
        second.value = second.value - 0.01;
      } else {
        gameOver = true.obs;
        if(level.value > highScore.value){
          saveDataFromLocal();
          getDataFromLocal();
          getHighScore.value = true;
        }
        if(getHighScore.value){
          showHighScoreGameDialog();
        }else{
          showEndGameDialog();
        }
        timer.cancel();
      }
    });
  }

  Future<bool?> showHighScoreGameDialog() {
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
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(
              color: Colors.blueAccent,
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
                Text('Congratulations', style: TextStyle(color: Colors.red,fontSize: 20),),
                Lottie.asset('assets/lottie/game-won.json', height: 399),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Your new record is : ${highScore.value}', style: TextStyle(color: Colors.white),),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                        restart();
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
        pauseGame.value = false;
      } else {
        return;
      }
    });
  }

  Future<bool?> showEndGameDialog() {
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
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(
            color: Colors.blueAccent,
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
              Lottie.asset('assets/lottie/game-over.json', height: 399),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Your score is : ${level.value}', style: TextStyle(color: Colors.white),),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      restart();
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
      pauseGame.value = false;
    } else {
      return;
    }
  });
}


  void onColorTap(int index) {
    if (!gameOver.value && index == diffIndex.value && !pauseGame.value) {
      if (audio.sfx.value) {
        audio.playAudio('correct.wav');
      }
      level++;
      bonus.value = (1.5 - (level.value / 100));
      showAnimation();
      second.value += bonus.value;
      sumBonus.value += bonus.value;
      if (sumBonus.value >= 10.00) {
        bonusStar.value += 1;
        sumBonus.value = 0;
      }
      updateData();
      Future.delayed(Duration(milliseconds: 300), () {
        show.value = false;
      });
      // Future.delayed(Duration(seconds: 1), (){
      //   audio.stopAudio("correct.wav");
      // });
    } else if (!gameOver.value) {
      if (audio.sfx.value) {
        audio.playAudio('wrong.wav');
      }
      // Future.delayed(Duration(seconds: 1), (){
      //   audio.stopAudio("wrong.wav");
      // });
    }
  }

  void restart() {
    getHighScore.value = false;
    gameOver.value = false;
    second.value = 60.00;
    level.value = 1;
    bonusStar.value = 0;
    sumBonus.value = 0;
    updateData();
    pauseGame.value = false;
    getDataFromLocal();
    setTimer();
  }

  void pause() {
    pauseGame.value = !pauseGame.value;
    if (!pauseGame.value) {
      setTimer();
    }
  }

  void showAnimation() {
    show.value = true;
  }
}
