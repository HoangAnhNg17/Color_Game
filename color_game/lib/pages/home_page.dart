import 'package:lottie/lottie.dart';
import 'package:color_game/pages/gameplay_page.dart';
import 'package:color_game/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:color_game/bloc/audio.dart';
import 'package:color_game/bloc/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    audio.onOff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=> const SettingPage());
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Get.off(()=> GamePlayPage());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white.withOpacity(0.8)),
                  ),
                  child: Text(
                    'Play Game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
