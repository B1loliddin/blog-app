import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnectedToInternet)) {
        return left(Failure(Constants.noInternetConnectionErrorMessage));
      }

      final UserModel user = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnectedToInternet)) {
        return left(Failure(Constants.noInternetConnectionErrorMessage));
      }

      final UserModel user = await authRemoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      debugPrint(e.message);
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnectedToInternet)) {
        final session = authRemoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User is not signed in'));
        }

        return right(UserModel(
          id: session.user.id,
          name: 'name',
          email: session.user.email ?? '',
        ));
      }

      final UserModel? user = await authRemoteDataSource.getCurrentUserData();

      return user != null
          ? right(user)
          : left(Failure('User is not signed in'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
