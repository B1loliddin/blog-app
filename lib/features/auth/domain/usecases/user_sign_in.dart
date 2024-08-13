import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository authRepository;

  const UserSignIn({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async {
    return await authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
