import 'package:fluchat/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppMainButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const AppMainButton(
      {super.key, required, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: MaterialButton(
        padding:
            const EdgeInsets.only(bottom: 12, top: 12, right: 24, left: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        color: Color3,
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
