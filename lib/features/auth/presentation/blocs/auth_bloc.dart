import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required GetCurrentUser getCurrentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _getCurrentUser = getCurrentUser,
        _appUserCubit = appUserCubit,
        super(const AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(const AuthLoading()));
    on<AuthSignUp>(_onUserSignUp);
    on<AuthSignIn>(_onUserSignIn);
    on<AuthGetCurrentUser>(_onGetCurrentUser);
  }

  void _onUserSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final Either<Failure, UserEntity> response = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (Failure failure) => emit(AuthFailure(message: failure.message)),
      (UserEntity user) => _emitUpdateUser(user, emit),
    );
  }

  void _onUserSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final Either<Failure, UserEntity> response = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (Failure failure) => emit(AuthFailure(message: failure.message)),
      (UserEntity user) => _emitUpdateUser(user, emit),
    );
  }

  void _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final Either<Failure, UserEntity> response =
        await _getCurrentUser(NoParams());

    response.fold(
      (Failure failure) => emit(AuthFailure(message: failure.message)),
      (UserEntity user) {
        debugPrint(user.name);

        return _emitUpdateUser(user, emit);
      },
    );
  }

  void _emitUpdateUser(
    UserEntity user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);

    emit(AuthSuccess(user: user));
  }
}
