import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';

class Audio extends GetxController{
  static final Audio _audio = Audio._internal();
  factory Audio() => _audio;
  Audio._internal();

  RxBool isPlaying = false.obs;
  RxString assetSound = "assets/sound/".obs;
  RxBool sfx = true.obs;

  AudioPlayer? player;

  void onOff() {
    isPlaying.value = !isPlaying.value;
    isPlaying.value ? playAudio('sound.mp3') : stopAudio('sound.mp3');
  }

  Future<void> playAudio(String file) async {
    player = AudioPlayer();
    player?.setAsset(assetSound.value + file);
    if(!audio.player!.playing) {
       player?.play();
      if(file == 'sound.mp3'){
        player?.setLoopMode(LoopMode.one);
      }else {
        player?.setLoopMode(LoopMode.off);
      }
    }
  }

  void stopAudio(String file) async{
    // player?.setAsset(assetSound.value + file);
    player?.stop();
  }


}

final audio = Audio();