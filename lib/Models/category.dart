class Message {
  final String image;
  final String name;

  Message(this.image, this.name);

  Message.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        name = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'name': name,
      };
}
