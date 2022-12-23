import 'dart:async';
import 'package:color_game/bloc/audio.dart';
import 'package:color_game/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 3), (timer) {
      Get.off(()=> HomePage());
      timer.cancel();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
