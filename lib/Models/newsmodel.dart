import 'dart:convert';

class NewsModel {
  final String category;

  final String description;
  final String gallery;
  final String image;
  final String status;
  final String title;
  NewsModel({
    required this.category,
    required this.description,
    required this.gallery,
    required this.image,
    required this.status,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'gallery': gallery,
      'image': image,
      'status': status,
      'title': title,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      category: map['category'] ?? "",
      description: map['description'] ?? "",
      gallery: map['gallery'] ?? "",
      image: map['image'] ?? "",
      status: map['status'] ?? "",
      title: map['title'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));
}
