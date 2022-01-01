class Livenews {
  final String image;
  final String title;
  final String description;

  Livenews(this.image, this.title, this.description);

  Livenews.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        title = json['title'] as String,
        description = json['description'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'title': title,
        'description': description,
      };
}
