import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async =>
      await blogRepository.getAllBlogs();
}
