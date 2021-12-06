import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget{

  final CameraDescription camera;

  CameraPage({
    Key? key,
    required this.camera,
  }) : super(key : key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{

  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState(){
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.max);
    _initializeControllerFuture = controller.initialize();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : FutureBuilder<void>(
        future : _initializeControllerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            return CameraPreview(controller);
          } else {
            return Center(child : CircularProgressIndicator());
          }
        },
      )
    );
  }
}