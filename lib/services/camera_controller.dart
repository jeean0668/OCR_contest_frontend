import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera_Controller extends GetxController{

  CameraController? controller;
  
  @override
  void onInit(){
    super.onInit();
    setupCamera();
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  Future setupCamera() async{
    final cameras = await availableCameras();
    controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
  }
}