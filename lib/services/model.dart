class EncodedText{

  final List<String> texts;
  final String filename;

  EncodedText({
    
    required this.filename,
    required this.texts,
  });

  factory EncodedText.fromJson(Map<String, dynamic> json){
    return EncodedText(
      filename: json['filename'] as String,
      texts: json['texts'] as List<String>
    ); 
  }
}
