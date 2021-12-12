import 'package:ai/services/controller.dart';
import "package:get/get.dart";
import "package:flutter/material.dart";
import "package:ai/services/controller.dart";
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_speech/google_speech.dart';
import "package:ai/services/tts_controller.dart";

// TTS has error. please check
class TTSPage extends GetView<DataController>{
  @override
  
  Widget build(BuildContext context){
  
    var message = controller.message![0].texts;
    TtsController tts_controller = Get.put(TtsController());

    return Scaffold(
      appBar: AppBar(
        title : Text('검색 결과'),
      ),
      body : Padding(
        padding: EdgeInsets.all(30.0),
        child : ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height : MediaQuery.of(context).size.height * 0.7,
              width : MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: MemoryImage(controller.imageData),
                  fit : BoxFit.fill,
                ),
              ),
            ),
            Text(
              '검색하신 결과입니다.',
              style : TextStyle(
                fontSize: 35,
              ),
            ),
            Text(message),
            ElevatedButton(
              child : Text('speak'),
              onPressed: () => tts_controller.speak(message),
            ),
          ],
        ),
      ),
    );
  }
}
