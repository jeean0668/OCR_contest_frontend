import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ai/services/file_picker_service.dart';
import 'package:ai/services/ml_services.dart';
import 'dart:typed_data';
import 'package:ai/services/model.dart';
import 'package:get/get.dart';
//import "package:ai/services/tts.dart";
import "package:flutter_tts/flutter_tts.dart";

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  final MLService _mlService = MLService();
  final FilePickerService _filePickerService = FilePickerService();
  
  //FlutterTts tts = FlutterTts();
  Uint8List? defaultImage;
  List<EncodedText>? saveMessage;

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.grey[400],
        
        centerTitle: true,
        titleSpacing: 20,
        title : Text(
          'Impressed Blind',
          style : TextStyle(
            fontFamily: 'karla',
            fontSize : 22,
          )
        ),
        actions: [
          IconButton(
            icon : Icon(Icons.image),
            onPressed : selectImage,
          ),
        ],
      ),
      body : SingleChildScrollView(
        child : Column(
          children : [
            LoadingImage(defaultImage),
            LoadingButtons(),
            LoadingOkText(saveMessage),
          ]
        )
      )
    );
  }

  Widget LoadingButtons(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon : Icon(Icons.camera_alt),
              color: Colors.grey[400],
              iconSize : 70,
              onPressed: (){},
              //onPressed: () => Get.toNamed("/camera"),
              
            ),
            IconButton(
              icon: Icon(Icons.image),
              color : Colors.grey[400],
              iconSize : 70,
              onPressed: selectImage,
            )
          ],
        ),
        SizedBox(height: 20,),
        Text('CopyRight 2021 by IB All Rights Reserved'),
      ],
    );
  }

  Widget LoadingOkText(List<EncodedText>? message){
    if (message == null) {
      return Center(
        child : Container(
          child : Text(
            'uploading is failed',
            style : TextStyle(
              fontSize : 18,
            ),
          ),
        ),
      );
    } else if (message.length == 0) {
       return Center(
        child : Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height : 5),
            Text('Loading'),
          ],
        ),
      );
    } else {
      print('ok');
      return Center(
        child : Container(
          child : Text(message[0].texts),
        ),
      );
    }
  }
  Widget LoadingImage(Uint8List? image){
    if (image == null){
      return Center(
        child : defaultBackground(context: context),
      );
    } else if (image.length == 0){
      return Center(
        child : Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height : 5),
            Text('Loading'),
          ],
        ),
      );
    } else {
      return Image.memory(
        image,
        fit : BoxFit.fitWidth,
      );
    }
  }
  void selectImage() async {
    setState((){
      defaultImage = Uint8List(0);
      //saveMessage = 'no';
    });
    var imageData = await _filePickerService.imageFilePickAsBytes();
    if (imageData != null){
      
      setState(() {
        defaultImage = imageData;
      });
      // image를 백엔드로 보내고 ok라는 message를 받는다.
      var saveImagemessage = await _mlService.convertImage(imageData);
      print(saveImagemessage.runtimeType);
      setState((){
        if (saveImagemessage == null){
          saveMessage = null;
        } else {
          saveMessage = saveImagemessage;
        }
      });
    } else {
      setState((){
        defaultImage = null;
        saveMessage = null;
      });
    }
  }
  
}

class defaultBackground extends StatelessWidget {
  const defaultBackground({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image : DecorationImage(
          image : AssetImage( "assets/images/back.jpg"),
          fit : BoxFit.cover,
        ),
      ),
      child : defaultBackgroundLogo(),
    );
  }
}

class defaultBackgroundLogo extends StatelessWidget {
  const defaultBackgroundLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height : 150.0,
            width: 250.0,
            child: Image(image: AssetImage('assets/images/logo.png'),)),
          SizedBox(height : 20.0),
          Column(
            children : [
              Text(
                'Impressed',
                style : TextStyle(
                  fontSize : 60.0,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w100,
                  color : Colors.grey[700],
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                'Blind',
                style : TextStyle(
                  fontSize : 40.0,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}