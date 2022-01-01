class Videomodel {
  final String image;
  final String title;
  final String gallery;
  final String description;

  Videomodel(this.image, this.title, this.gallery, this.description);

  Videomodel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        title = json['title'] as String,
        gallery = json['gallery'] as String,
        description = json['description'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'title': title,
        'description': description,
      };
}
