class EncodedText{

  final String texts;
  final String filename;
  final String ingredients;

  EncodedText({

    required this.ingredients,    
    required this.filename,
    required this.texts,
  });

  factory EncodedText.fromJson(Map<String, dynamic> json){
    return EncodedText(
      filename: json['filename'] as String,
      texts: json['texts'] as String,
      ingredients: json['ingredients'] as String,
    ); 
  }
}
