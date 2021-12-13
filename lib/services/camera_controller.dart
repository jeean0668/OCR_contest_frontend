import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera_Controller extends GetxController{

  List<CameraDescription>? cameras;
  CameraController? controller;
  bool _isCameraInitialized = false;

  @override
  void onInit(){
    super.onInit();
    findCamera();
    openController();
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  findCamera() async{
    try{
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch(e){
      print('Error in fetching the cameras : $e');
    }
  }

  openController() {
    final CameraController cameraController = CameraController(
      cameras![0], 
      ResolutionPreset.max,
    );
    controller = cameraController;
  }
}