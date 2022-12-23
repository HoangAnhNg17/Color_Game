import 'package:flutter/material.dart';
import '../bloc/audio.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:get/get.dart';

import '../bloc/theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var notifier1 = ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    notifier1.addListener(() {
      setState(() {
        if (notifier1.value) {
          audio.isPlaying.value = true;
          audio.onOff();
        } else {
          audio.isPlaying.value = false;
          audio.onOff();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: buildSetting(),
    );
  }

  Widget buildSetting() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'GAME SETTINGS',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 30),child: Image.asset('assets/photos/pets.png')),
          Divider(color: Colors.grey,thickness: 1,),
          rowSettings(nameSetting: 'Dark mode', val: theme.isDarkMode.value),
          rowSettings(nameSetting: 'Sound', val: audio.isPlaying.value),
          rowSettings(nameSetting: 'SFX', val: audio.sfx.value),
          SizedBox(
            height: 7,
          ),
          Text(
            'Shape',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 35,),
          buildShapeOption(),
        ],
      ),
    );
  }

  Widget buildShapeOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCheckBox(value: 10.00, idx: 0, color: Colors.blue),
        buildCheckBox(value: 0.00, idx: 1, color: Colors.purpleAccent),
        buildCheckBox(value: 150.0, idx: 2, color: Colors.brown),
      ],
    );
  }

  Widget buildCheckBox({required value, required idx, required color}) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(value),
            color: color,
          ),
        ),
        Checkbox(
          side: BorderSide(
            color: Colors.white,
            width: 2
          ),
          // activeColor: Colors.blue,
          value: theme.listCheckBox.value[idx],
          onChanged: (val) {
            theme.shape.value = value;
            setState(() {
              theme.handleList(idx);
            });
          },
        )
      ],
    );
  }

  Widget rowSettings({required nameSetting, required bool val}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameSetting,
            style: TextStyle(color: Colors.white),
          ),
          SwitcherButton(
            onColor: Colors.greenAccent,
            offColor: Colors.pinkAccent,
            value: val,
            onChange: (value) {
              if (nameSetting == 'Sound') {
                audio.onOff();
              } else if (nameSetting == 'SFX') {
                audio.sfx.value = !audio.sfx.value;
              } else if (nameSetting == 'Dark mode') {
                theme.changeMode();
                Get.changeThemeMode(
                  theme.isDarkMode.value ? ThemeMode.light : ThemeMode.dark,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
