import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/show_snack_bar.dart';
import 'package:blog_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _initializeAllControllers();
  }

  @override
  void dispose() {
    _disposeAllControllers();
    super.dispose();
  }

  void _initializeAllControllers() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _disposeAllControllers() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _onSignInButtonPressed() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignIn(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  void _navigateToSignUpPage() => Navigator.pushReplacementNamed(
        context,
        '/sign_up_page',
      );

  void _navigateToBlogPage() => Navigator.pushReplacementNamed(
        context,
        '/blog_page',
      );

  void textFieldUnFocus() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: textFieldUnFocus,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (_, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                _navigateToBlogPage();
              }
            },
            builder: (_, state) {
              if (state is AuthLoading) {
                return Loading();
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    AuthField(hintText: 'Email', controller: _emailController),
                    SizedBox(height: 15),
                    AuthField(
                        hintText: 'Password', controller: _passwordController),
                    SizedBox(height: 20),
                    AuthGradientButton(
                      buttonText: 'Sign In',
                      onPressed: _onSignInButtonPressed,
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = _navigateToSignUpPage,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallet.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
