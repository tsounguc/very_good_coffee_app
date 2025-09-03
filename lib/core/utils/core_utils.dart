import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
    BuildContext context,
    String message, {
    int durationInMilliSecond = 3000,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          duration: Duration(milliseconds: durationInMilliSecond),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(
                bottom: MediaQuery.of(context).size.height * 0.05,
              ),
        ),
      );
  }
}
