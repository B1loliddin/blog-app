import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  const UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      blogId: params.blogId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String blogId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.blogId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
