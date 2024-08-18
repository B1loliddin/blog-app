import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  /// The function [signUp] is used to signUp the user into an application,
  /// using credentials like [name], [email] and [password] as well.
  /// If something goes wrong, it throws a [ServerException] error.
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// The function [signIn] is used to signIn the user into an application,
  /// using credentials like [email] and [password].
  /// If something goes wrong, it throws a [ServerException] error.
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  /// The function [getCurrentUserData] is used to get information like [id], [name] and [email]
  /// about current user. If user does not exist in the database, it throws
  /// [ServerException] error.
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  const AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      return response.user == null
          ? throw ServerException('User is null')
          : UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response =
          await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user == null
          ? throw ServerException('User is null')
          : UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final List<Map<String, dynamic>> userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);

        return UserModel.fromJson(userData.first);
      }

      return null;
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e.toString());
    }
  }
}
