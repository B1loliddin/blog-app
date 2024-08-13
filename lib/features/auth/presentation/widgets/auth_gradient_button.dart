import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.sizeOf(context).width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          gradient: LinearGradient(
            colors: [AppPallet.gradient1, AppPallet.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallet.transparentColor,
            shadowColor: AppPallet.transparentColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
