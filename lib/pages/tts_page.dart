import 'package:ai/services/controller.dart';
import "package:get/get.dart";
import "package:flutter/material.dart";
import "package:ai/services/controller.dart";
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_speech/google_speech.dart';
import "package:ai/services/tts_controller.dart";

// TTS has error. please check
class TTSPage extends GetView<DataController>{
  
  @override
  Widget build(BuildContext context){
  
    var message = controller.message![0].texts;
    TtsController tts_controller = Get.put(TtsController());
    var sizeBoxHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      appBar: AppBar(
        title : Text('검색 결과'),
      ),
      body : Padding(
        padding: EdgeInsets.all(30.0),
        child : ListView(
          scrollDirection: Axis.vertical,
          children: [
            
            SizedBox(height: sizeBoxHeight * 0.3),
            Text(
              '검색하신 결과입니다.',
              style : GoogleFonts.sunflower(
                textStyle: TextStyle(fontSize : 30),
              ),
            ),
            Container(height:3.0, color : Colors.blue),
            SizedBox(height:sizeBoxHeight*0.5),
            TTSPageImage(context),
            SizedBox(height:sizeBoxHeight*0.3),
            TTSPageMessages(message),
            IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => tts_controller.speak(message),
            ),
          ],
        ),
      ),
    );
  }

  Card TTSPageMessages(String message) {
    return Card(
      child: Container(
        padding : EdgeInsets.all(5.0),
        child: Text(
          message,
          style : GoogleFonts.sunflower(
            textStyle : TextStyle(
              fontSize : 19.0,
            ),
          ),  
        ),
      ),
    );
  } 

  Container TTSPageImage(BuildContext context) {
    return Container(
            height : MediaQuery.of(context).size.height * 0.5,
            width : MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: MemoryImage(controller.imageData),
                fit : BoxFit.fill,
                
              ),
            ),
          );
  }
}
