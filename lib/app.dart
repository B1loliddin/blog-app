import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogApp extends StatefulWidget {
  const BlogApp({super.key});

  @override
  State<BlogApp> createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthGetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      routes: {
        '/sign_up_page': (context) => const SignUpPage(),
        '/sign_in_page': (context) => const SignInPage(),
        '/blog_page': (context) => const BlogPage(),
        '/add_new_blog_page': (context) => const AddNewBlogPage(),
        '/blog_details_page': (context) => const BlogDetailsPage(),
      },
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserSignedIn;
        },
        builder: (_, isSignedIn) {
          if (isSignedIn) {
            return const BlogPage();
          }

          return const SignInPage();
        },
      ),
    );
  }
}
