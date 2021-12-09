import 'package:ai/services/controller.dart';
import "package:get/get.dart";
import "package:flutter/material.dart";
import "package:ai/services/controller.dart";

class TTSPage extends GetView<DataController>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Padding(
        padding: EdgeInsets.all(30.0),
        child : Text('${controller.message![0].texts}'),
      ),
    );
  }
}