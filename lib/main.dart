import 'package:blog_app/app.dart';
import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => serviceLocator()),
        BlocProvider<AppUserCubit>(create: (_) => serviceLocator()),
        BlocProvider<BlogBloc>(create: (_) => serviceLocator()),
      ],
      child: const BlogApp(),
    ),
  );
}
