
import 'package:ai/services/model.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:ai/services/ml_services.dart';
import 'package:ai/services/file_picker_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ai/services/camera_controller.dart';

class DataController extends GetxController with StateMixin{

  List<EncodedText>? message; 
  var ml_services = MLService();
  var _filePickerService = FilePickerService();
  var imageData;
  
  take_picture() async{
    Camera_Controller controller = Get.put(Camera_Controller());
    
  }

  select_file() async{
    imageData = await _filePickerService.imageFilePickAsBytes();
    getData();
  }
  getData() async {

    // make status loading
    change(null, status : RxStatus.loading());

    // code get data
    
    if (imageData != null){
      message = await ml_services.convertImage(imageData);
    };
    if (message == null){
      change(null, status : RxStatus.error());
    } else {
      change(message, status: RxStatus.success());
    }
  }

}