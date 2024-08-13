part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class AppUserSignedIn extends AppUserState {
  final UserEntity user;

  const AppUserSignedIn({required this.user});
}
