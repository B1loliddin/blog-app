import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final Either<Failure, BlogEntity> response = await _uploadBlog(
      UploadBlogParams(
        blogId: event.blogId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    response.fold(
      (Failure failure) => emit(BlogFailure(message: failure.message)),
      (BlogEntity blog) => emit(BlogUploadBlogSuccess()),
    );
  }

  void _onGetAllBlogs(BlogGetAllBlogs event, Emitter<BlogState> emit) async {
    final response = await _getAllBlogs(NoParams());

    response.fold(
      (Failure failure) => emit(BlogFailure(message: failure.message)),
      (List<BlogEntity> blogs) => emit(BlogGetAllBlogsSuccess(blogs: blogs)),
    );
  }
}
