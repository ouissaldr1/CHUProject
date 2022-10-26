class Article {
  Article({required this.titre, required this.date,required this.image,required this.text });

  Article.fromJson(Map<String, Object?> json)
    : this(
        titre: json['titre']! as String,
        date: json['date']! as String,
        image: json['image']! as String,
        text: json['text']! as String
      );

   String titre;
   String date;
   String image;
   String text;

  Map<String, Object?> toJson() {
    return {
      'titre': titre,
      'date': date,
      'image': image,
      'text': text
    };
  }
}