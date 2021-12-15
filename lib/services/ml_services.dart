import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ai/services/model.dart';

class MLService{
  Dio dio = Dio();

  Future<List<EncodedText>?> convertImage(Uint8List imageData) async{
    
    try{
      Response response = await sendImageFile(imageData);
      if (response.statusCode == 200){
        // 판독된 text를 json형식으로 받는다.
        var responseBody = response.data;
        // http로 받은 데이터를 decode 한거 = dio로 get한 response.data
        // 즉, decode 할 필요가 없다. 
        var filename = responseBody['filename'];
        var texts = responseBody['texts'];
        var ingredients = responseBody['ingredients'];
        var result = <EncodedText>[];
        result.add(EncodedText(filename: filename, texts: texts, ingredients: ingredients ));
    
        return result;

      } else {
        return null;
      }
    } catch(e){
      return null;
    }
  }
  Future<Response> sendImageFile(Uint8List image) async{
    var encodedData = await compute(base64Encode, image);
    FormData formData = FormData.fromMap({
      'file' : encodedData,
    });
    Response response = await dio.post(
      "http://180.64.184.81:8000/upload",
      data : formData,

    );
    return response;
  }

  List<EncodedText> encodedTexts(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<EncodedText>((json) => EncodedText.fromJson(json)).toList();
  }
}
