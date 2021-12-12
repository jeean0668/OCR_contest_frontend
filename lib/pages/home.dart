import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ai/services/file_picker_service.dart';
import 'package:ai/services/ml_services.dart';
import 'dart:typed_data';
import 'package:ai/services/model.dart';
import 'package:get/get.dart';
import 'package:ai/services/controller.dart';

class Home extends GetView<DataController> {

  final MLService _mlService = MLService();
  final FilePickerService _filePickerService = FilePickerService();
  final Controller = Get.put(DataController());
  List<EncodedText>? saveMessage;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.grey[400],
        
        centerTitle: true,
        titleSpacing: 20,
        title : loadingAppTitle(),
      ),
      body : Column(
        children : [
          LoadingImage(),
          LoadingButtons(context),
        ]
      ),
    );
  }

  Text loadingAppTitle() {
    return Text(
        'Impressed Blind',
        style : TextStyle(
          fontFamily: 'karla',
          fontSize : 18,
        )
      );
  }

  Widget LoadingButtons(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            loadingCameraButton(),
            loadingGalleryButton()
          ],
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  IconButton loadingGalleryButton() {
    return IconButton(
            icon: Icon(Icons.image),
            color : Colors.grey[400],
            iconSize : 70,
            onPressed: () => Get.toNamed('/waiting'),
          );
  }

  IconButton loadingCameraButton() {
    return IconButton(
            icon : Icon(Icons.camera_alt),
            color: Colors.grey[400],
            iconSize : 70,
            onPressed: (){},
            //onPressed: () => Get.toNamed("/camera"),
            
          );
  }

  Widget LoadingImage(){
    return Center(
      child : defaultBackground(),
    );
  }
}

class defaultBackground extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
                  fontSize : 45.0,
                  fontFamily: 'Karla',
                  fontWeight: FontWeight.w100,
                  color : Colors.grey[700],
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                'Blind',
                style : TextStyle(
                  fontSize : 35.0,
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