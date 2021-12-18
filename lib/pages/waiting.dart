import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai/services/model.dart';
import 'package:ai/services/controller.dart';
import 'package:ai/pages/tts_page.dart';


class Waiting extends GetView<DataController>{
  
  int isCamera;

  Waiting({
    Key? key,
    required this.isCamera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // image file을 선택
    if (isCamera == 0){
      controller.take_picture();
    } else if(isCamera == 1) {
      controller.select_file();
    } 

    return Scaffold(
      body : controller.obx((state){
        
        if (controller.message != null){
          return TTSPage();
        } else {
          return Text('Cannot call the texts');
        }
      },
      onLoading: LoadingPage(context),
      onError : (error) => Text('Sorry. It could not connect : ${error}'),
      )
    );
  }
  Widget LoadingPage(BuildContext context){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingPageTitle(),
          SizedBox(height: 10,),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
  Widget LoadingPageTitle(){
    return Text(
      '데이터 변환 중입니다.',
      style : TextStyle(
        fontSize : 30,
      ),
    );
  }
}





  





