
import 'package:ai/services/model.dart';
import 'package:get/get.dart';
//import 'package:ai/services/model.dart';
import 'package:ai/services/ml_services.dart';
import 'package:ai/services/file_picker_service.dart';

class DataController extends GetxController with StateMixin{

  List<EncodedText>? message; 
  var ml_services = MLService();
  var _filePickerService = FilePickerService();
  var imageData;
  
  select_file() async{
    imageData = await _filePickerService.imageFilePickAsBytes();
    print('ok1');
  }
  getData() async {

    // make status loading
    change(null, status : RxStatus.loading());

    // code get data
    if (imageData != null){
      message = await ml_services.convertImage(imageData);
    }

    // if done, change status to success
    change(message, status: RxStatus.success());
  
  }

  @override
  void onInit(){
    super.onInit();
  }
}