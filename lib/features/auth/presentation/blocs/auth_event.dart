part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({
    required this.email,
    required this.password,
  });
}

final class AuthGetCurrentUser extends AuthEvent {
  const AuthGetCurrentUser();
}
