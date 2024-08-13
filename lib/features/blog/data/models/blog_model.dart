import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  const BlogModel({
    required super.id,
    required super.updatedAt,
    required super.blogId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    super.userName,
  });

  factory BlogModel.fromJson(Map<String, Object?> json) {
    final String id = json['id'] as String;
    final DateTime updatedAt = json['updated_at'] == null
        ? DateTime.now()
        : DateTime.parse(json['updated_at'] as String);
    final String blogId = json['blog_id'] as String;
    final String title = json['title'] as String;
    final String content = json['content'] as String;
    final String imageUrl = json['image_url'] as String;
    final List<String> topics = List<String>.from(json['topics'] as List);

    return BlogModel(
      id: id,
      updatedAt: updatedAt,
      blogId: blogId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      topics: topics,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'blog_id': blogId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
    };
  }

  BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? blogId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    String? userName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      blogId: blogId ?? this.blogId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      userName: userName ?? this.userName,
    );
  }
}
