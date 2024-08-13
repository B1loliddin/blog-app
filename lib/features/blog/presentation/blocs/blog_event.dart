part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String blogId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.image,
    required this.title,
    required this.content,
    required this.blogId,
    required this.topics,
  });
}

final class BlogGetAllBlogs extends BlogEvent {}
