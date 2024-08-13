part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}
