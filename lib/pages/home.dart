import 'package:flutter/material.dart';
import 'package:ai/services/file_picker_service.dart';
import 'package:ai/services/ml_services.dart';
import 'dart:typed_data';
import 'package:ai/services/model.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{

  final MLService _mlService = MLService();
  final FilePickerService _filePickerService = FilePickerService();

  Uint8List? defaultImage;
  List<EncodedText>? saveMessage; 

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title : Text('Flask Image API Test'),
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
            Icon(
              Icons.keyboard_arrow_down,
              size : 50,
            ),
            LoadingOkText(saveMessage),
          ]
        )
      )
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
      print(message[0].texts.length);
      print(message[0].texts);
      return Center(
        
        child : Container(
          child : ListView.builder(
            shrinkWrap: true,
            itemCount: message[0].texts.length,
            itemBuilder : (context, index) {
              print(message[0].texts[index]);
              return ListTile(
                title : Text('Item : ${message[0].texts[index]}'),
              );
            }
          ),
        ),
      );
    }
  }
  Widget LoadingImage(Uint8List? image){
    if (image == null){
      return Center(
        child : Container(
          child : Text(
            'No Image',
            style : TextStyle(
              fontSize : 18,
            ),
          ),
        )
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