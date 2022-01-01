class Source {
  final String image;
  final String name;

  Source(this.image, this.name);

  Source.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        name = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'name': name,
      };
}
