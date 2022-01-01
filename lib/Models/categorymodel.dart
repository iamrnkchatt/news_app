class CategoryModel {
  final String image;
  final String name;
  final String status;

  CategoryModel(this.image, this.name, this.status);

  CategoryModel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        name = json['name'] as String,
        status = json['status'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'image': image, 'name': name, 'status': status};

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'status': status,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      map['image'] ?? "",
      map['name'] ?? "",
      map['status'] ?? "",
    );
  }

  @override
  String toString() => 'Message(email: $image, name: $name, photoUrl: $status)';
}
