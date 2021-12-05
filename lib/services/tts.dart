import "package:flutter/material.dart";
import "package:flutter_tts/flutter_tts.dart";
import 'package:flutter_tts/flutter_tts_web.dart';
import 'dart:html' as html;
import 'dart:js';

class TTS{
  
  FlutterTts flutterTts = FlutterTts();

  Future _speak() async{
    flutterTts.setLanguage("ko");
    flutterTts.setSpeechRate(0.7);
    await flutterTts.speak("안녕하세요");
  }
}
