part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}

final class BlogUploadBlogSuccess extends BlogState {}

final class BlogGetAllBlogsSuccess extends BlogState {
  final List<BlogEntity> blogs;

  BlogGetAllBlogsSuccess({required this.blogs});
}
