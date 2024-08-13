class BlogEntity {
  final String id;
  final DateTime updatedAt;
  final String blogId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final String? userName;

  const BlogEntity({
    required this.id,
    required this.updatedAt,
    required this.blogId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    this.userName,
  });
}
