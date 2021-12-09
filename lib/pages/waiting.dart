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
        return Text('${controller.message![0].texts}');
      },
      onLoading: LoadingPage(),
      onError : (error) => Text('Sorry. It could not connect'),
      )
    );
  }
  Widget LoadingPage(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        children: [
          LoadingPageTitle(),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
  Widget LoadingPageTitle(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(30,60,30,60),
      child: Text(
        '데이터 변환 중입니다.',
        style : TextStyle(
          fontSize : 30,
        ),
      ),
    );
  }
}





  





