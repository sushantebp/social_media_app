import 'package:flutter/material.dart';
import 'package:social_media_app/core/exten/build_context_extension.dart';

class SparkButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final TextStyle? textStyle;

  const SparkButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(offset: Offset(4, 3), color: colorScheme.onSurface),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.8, color: colorScheme.onSurface),
            borderRadius: BorderRadiusGeometry.circular(6),
          ),
        ),
        onPressed: onPressed,
        child: Text(title, style: textStyle),
      ),
    );
  }
}
