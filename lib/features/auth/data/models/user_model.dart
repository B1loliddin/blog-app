import 'package:blog_app/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, Object?> json) {
    final String id = (json['id'] ?? '') as String;
    final String name = (json['name'] ?? '') as String;
    final String email = (json['email'] ?? '') as String;

    return UserModel(id: id, name: name, email: email);
  }
}
