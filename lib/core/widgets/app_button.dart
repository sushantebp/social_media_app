import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary, outlined, icon, text }

class AppButton extends StatelessWidget {
  final String? title;
  final IconData? icon;

  final VoidCallback? onPressed;

  final bool isLoading;

  final AppButtonType type;

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  final double borderRadius;
  final double? elevation;

  final Color? bgColor;
  final Color? fgColor;

  const AppButton({
    super.key,
    this.title,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.type = AppButtonType.primary,
    this.width,
    this.height = 48,
    this.padding,
    this.textStyle,
    this.borderRadius = 12,
    this.elevation,
    this.bgColor,
    this.fgColor,
  }) : assert(
         title != null || icon != null,
         'Either title or icon must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine background color, use bgColor if provided
    Color backgroundColor =
        bgColor ??
        switch (type) {
          AppButtonType.primary => colorScheme.primary,
          AppButtonType.secondary => colorScheme.secondary,
          AppButtonType.outlined => Colors.transparent,
          AppButtonType.icon => Colors.transparent,
          AppButtonType.text => Colors.transparent,
        };

    // Determine foreground (text/icon) color, use fgColor if provided
    Color foregroundColor =
        fgColor ??
        switch (type) {
          AppButtonType.primary => colorScheme.onPrimary,
          AppButtonType.secondary => colorScheme.onSecondary,
          AppButtonType.outlined => colorScheme.primary,
          AppButtonType.icon => colorScheme.primary,
          AppButtonType.text => colorScheme.primary,
        };

    // Border for outlined type
    BorderSide? border = type == AppButtonType.outlined
        ? BorderSide(color: colorScheme.primary, width: 2)
        : null;

    // Use TextButton for text type
    if (type == AppButtonType.text) {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle:
              textStyle ??
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: foregroundColor,
                  strokeWidth: 2,
                ),
              )
            : _buildChild(foregroundColor),
      );
    }

    // ElevatedButton for other types
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          elevation: elevation ?? (type == AppButtonType.outlined ? 0 : 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          ),
        ),
        // Show loading indicator or button content
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: foregroundColor,
                ),
              )
            : _buildChild(foregroundColor),
      ),
    );
  }

  // Build child widget: text, icon, or both
  Widget _buildChild(Color fgColor) {
    final style =
        textStyle ?? TextStyle(fontWeight: FontWeight.w600, color: fgColor);

    if (icon != null && title != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: fgColor),
          const SizedBox(width: 8),
          Text(title!, style: style),
        ],
      );
    } else if (icon != null) {
      return Icon(icon, size: 24, color: fgColor);
    } else {
      return Text(title!, style: style);
    }
  }
}
