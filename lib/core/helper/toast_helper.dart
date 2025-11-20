import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToastHelper {
  ToastHelper._();

  static void _showToast(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, style: TextStyle(color: textColor)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    final theme = Theme.of(context);
    _showToast(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
      textColor: theme.colorScheme.onPrimary,
      icon: FontAwesomeIcons.circleCheck,
    );
  }

  static void info(BuildContext context, String message) {
    final theme = Theme.of(context);
    _showToast(
      context,
      message: message,
      backgroundColor: theme.colorScheme.tertiary,
      textColor: theme.colorScheme.onTertiary,
      icon: FontAwesomeIcons.circleInfo,
    );
  }

  static void warning(BuildContext context, String message) {
    _showToast(
      context,
      message: message,
      backgroundColor: Colors.orange.shade700,
      textColor: Colors.black,
      icon: FontAwesomeIcons.triangleExclamation,
    );
  }

  static void error(BuildContext context, String message) {
    final theme = Theme.of(context);
    _showToast(
      context,
      message: message,
      backgroundColor: theme.colorScheme.error,
      textColor: theme.colorScheme.onError,
      icon: FontAwesomeIcons.circleXmark,
    );
  }
}
