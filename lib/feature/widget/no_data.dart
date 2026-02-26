import 'package:flutter/material.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';

class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const EmptyStateWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
    this.iconSize = 80,
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: AppColors.primary),
            const SizedBox(height: 24),
            CommonText(
              title,
              textAlign: TextAlign.center,
              size: 18,
              isBold: true,
            ),
            const SizedBox(height: 12),
            CommonText(description, textAlign: TextAlign.center, size: 14),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: 180,
                height: 50,
                child: CommonButton(
                  buttonText!,
                  onTap: onButtonPressed,
                  textSize: 14,
                  boarderRadious: 8,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
