import 'package:ai/services/tts_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsController extends GetxController{

  FlutterTts? tts;
  Future<dynamic>? engine;
  List<dynamic>? languages;
  String defaultEngine = 'ko-KR';

  @override
  void onInit(){
    super.onInit();
    tts = FlutterTts();
    initializeEngines();
    initializeLanguages();
  }

  void initializeEngines() async{
    engine = tts!.getDefaultEngine;
    tts!.setEngine(engine.toString());
  }

  void initializeLanguages() async{
    languages = await tts!.getEngines;
    tts!.setLanguage(defaultEngine);
  }
  void speak(String texts){
    tts!.speak(texts);
  }
}