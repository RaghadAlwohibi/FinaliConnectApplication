import 'package:iconnect/utils/utils.dart';

class User {
  String id;
  String name;
  String photo;
  String email;
  String major;
  bool isAdmin = false;
  String username;
  String bio;
  User(
      {this.id,
      this.email,
      this.name,
      this.photo,
      this.isAdmin = false,
      this.bio,
      this.major,
      this.username});

  factory User.fromJson(Map<dynamic, dynamic> doc) {
    return User(
        id: doc['id'],
        major: doc['major'] ?? 'CS',
        email: doc['email'],
        username: doc['username'],
        name: doc['name'],
        isAdmin: doc['isAdmin'],
        bio: doc['bio'],
        photo: doc['photo']);
  }
  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'major': user.major,
      'email': user.email,
      'username': user.username,
      'name': user.name,
      'bio': user.bio,
      'isAdmin': user.isAdmin,
      'photo': user.photo,
      
    };
  }
}


