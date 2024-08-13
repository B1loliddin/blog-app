import 'dart:io';

import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  const BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.blogLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String blogId,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnectedToInternet)) {
        return left(Failure(Constants.noInternetConnectionErrorMessage));
      }

      BlogModel blog = BlogModel(
        id: Uuid().v1(),
        updatedAt: DateTime.now(),
        blogId: blogId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
      );

      final String imageUrl = await blogRemoteDataSource.uploadBlogImage(
        file: image,
        blog: blog,
      );

      blog = blog.copyWith(imageUrl: imageUrl);

      final BlogModel uploadedBlog =
          await blogRemoteDataSource.uploadBlog(blog);

      return right(uploadedBlog);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnectedToInternet)) {
        final List<BlogModel> blogs = blogLocalDataSource.getAllLocalBlogs();

        return right(blogs);
      }

      final List<BlogModel> blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadAllRemoteBlogsToLocal(blogs: blogs);

      return right(blogs);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
