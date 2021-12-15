import "package:get/get.dart";
import "package:flutter/material.dart";
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_speech/google_speech.dart';

import 'package:ai/services/controller.dart';
import "package:ai/services/controller.dart";
import "package:ai/services/tts_controller.dart";

// TTS has error. please check
class TTSPage extends GetView<DataController> {
  @override
  Widget build(BuildContext context) {
    TtsController tts_controller = Get.put(TtsController());
    var sizeBoxHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: controller.message!.length,
          itemBuilder: (context, index) {
            return buildResult(context: context, index: index);
          },
        ),
      ),
    );
  }
}

class buildResult extends StatelessWidget {
  BuildContext? context;
  int? index;
  buildResult({
    Key? key,
    required this.context,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();
    var message = controller.message![0].texts;
    var information = controller.message![0].ingredients;
    var data = [message, information];
    var titles = ['제품명', '성분 정보'];

    final sizeBoxHeight = MediaQuery.of(context).size.height * 0.1;
    return Column(
      children: [
        SizedBox(height: sizeBoxHeight * 0.3),
        Text(
          '검색하신 결과입니다.',
          style: GoogleFonts.sunflower(
            textStyle: TextStyle(fontSize: 30),
          ),
        ),
        Container(height: 3.0, color: Colors.blue),
        SizedBox(height: sizeBoxHeight * 0.5),
        TTSPageImage(context),
        SizedBox(height: sizeBoxHeight * 0.3),
        buildMessage(context: context, data: data[0], title: titles[0]),
        buildMessage(context: context, data: data[1], title: titles[1]),
      ],
    );
  }

  Container TTSPageImage(BuildContext context) {
    final controller = Get.find<DataController>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: MemoryImage(controller.imageData),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class buildMessage extends StatelessWidget {
  BuildContext? context;
  String? data;
  String? title;

  buildMessage({
    Key? key,
    required this.context,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tts_controller = Get.find<TtsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(title!,
            style: GoogleFonts.sunflower(
                textStyle: TextStyle(
              fontSize: 15.0,
            ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 18,
              child: Card(
                child: Container(
                  width : MediaQuery.of(context).size.width*0.9,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Text(
                    data!,
                    style: GoogleFonts.sunflower(
                      textStyle: TextStyle(
                        fontSize: 19.0,
                      ),
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
            Spacer(flex : 1),
            Flexible(
              flex: 2,
              child: IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () => tts_controller.speak(data!),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
