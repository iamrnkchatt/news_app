class News {
  final String image;
  final String title;
  final String description;

  News(this.image, this.title, this.description);

  News.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        title = json['title'] as String,
        description = json['description'] as String;

  Map<dynamic, dynamic> toJson() => <

  dynamic

  ,

  dynamic

  >{
  'image': image,
  'title': title,
  'description':description,
  };
}
