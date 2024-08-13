import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String blogId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
