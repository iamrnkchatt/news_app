class UserModel {
  final String email;
  final String name;
  final String photoUrl;

  UserModel(this.email, this.name, this.photoUrl);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : email = json['email'] as String,
        name = json['name'] as String,
        photoUrl = json['photoUrl'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'email': email, 'name': name, 'photoUrl': photoUrl};

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['email'],
      map['name'],
      map['photoUrl'],
    );
  }

  @override
  String toString() =>
      'Message(email: $email, name: $name, photoUrl: $photoUrl)';
}
