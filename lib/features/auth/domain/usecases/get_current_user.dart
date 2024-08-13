import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  const GetCurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) =>
      authRepository.getCurrentUser();
}
