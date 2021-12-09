import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai/services/model.dart';
import 'package:ai/services/controller.dart';

class Waiting extends GetView<DataController>{

  @override
  Widget build(BuildContext context){
    // image file을 선택
    controller.select_file();
    // send image to backend and get the texts
    controller.getData();
    return Scaffold(
      body : controller.obx((state){
        print(controller.message![0].texts);
        return Text('${controller.message![0]}');
      },
      onLoading: Center(child:CircularProgressIndicator()),
      onError : (error) => Text('Sorry. It could not connect'),
      )
    );
  }
}
  





