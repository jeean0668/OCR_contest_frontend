import 'package:ai/pages/home.dart';
import 'package:ai/pages/waiting.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai/pages/tts_page.dart';
import 'package:ai/pages/camera_page.dart';
import 'dart:async';
import 'dart:io';


Future<void> main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      title: 'Test Flask API',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Home()),
      ],
    );
  }
}