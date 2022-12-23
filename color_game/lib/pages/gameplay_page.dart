import 'package:color_game/widget/end_game_dialog.dart';
import 'package:color_game/widget/new_high_score_dialog.dart';
import 'package:color_game/widget/pause_game_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bloc/gameplay.dart';
import 'package:lottie/lottie.dart';
import 'package:color_game/bloc/theme.dart';

class GamePlayPage extends StatefulWidget {
  const GamePlayPage({Key? key}) : super(key: key);

  @override
  State<GamePlayPage> createState() => _GamePlayPageState();
}

class _GamePlayPageState extends State<GamePlayPage> {
  final gamePlay = Get.put(GamePlay());

  @override
  void initState() {
    // TODO: implement initState
    gamePlay.updateData();
    gamePlay.setTimer();
    gamePlay.getDataFromLocal();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    gamePlay.context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              onTap: () {
                gamePlay.pause();
                showPauseGameDialog(context: context, gamePlay: gamePlay);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.pause,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 0,
                  child: Obx(
                        () =>
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: gamePlay.bonusStar.value,
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              size: 25,
                              color: Colors.yellow,
                            );
                          },
                        ),
                  )),
              buildLevelBar(),
              Obx(() => buildSquare()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSquare() {
    final cAxisCount = gamePlay.crossAxisCount.value;
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height / 2,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cAxisCount,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: cAxisCount * cAxisCount,
        itemBuilder: (context, index) {
          return buildColorBox(index);
        },
      ),
    );
  }

  Widget buildColorBox(int index) {
    return GestureDetector(
      onTap: () {
        gamePlay.onColorTap(index);
      },
      child: Obx(
            () =>
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: index != gamePlay.diffIndex.value
                      ? Color(gamePlay.color.value)
                      : Color(gamePlay.diffColor.value),
                  borderRadius: BorderRadius.circular(theme.shape.value),
                ),
                // child: Text(gamePlay.second.toString()),
              ),
              if (index == gamePlay.diffIndex.value &&
                  gamePlay.showStar.value) ...{
                Lottie.asset('assets/lottie/star-effect.json'),
              }
            ]),
      ),
    );
  }

  Widget buildLevelBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Level',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() =>
                  Text(gamePlay.level.toString(),
                      style: TextStyle(color: Colors.white))),
            ],
          ),
          GestureDetector(
              onTap: () {
                if(gamePlay.bonusStar != 0) {
                  gamePlay.showStar.value = true;
                  gamePlay.bonusStar.value -= 1;
                }
              },
              child: Lottie.asset('assets/lottie/cheering.json', width: 200)),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child:
                      Text('Timer', style: TextStyle(color: Colors.pink))),
                  Obx(
                        () =>
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 250),
                          top: gamePlay.show.value ? -1 : 20,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: gamePlay.show.value ? 1 : 0,
                            child: Text(
                              '+${gamePlay.bonus.value}',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // margin: EdgeInsets.only(bottom: 20),
                child: Obx(() =>
                    Text('${gamePlay.second.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}