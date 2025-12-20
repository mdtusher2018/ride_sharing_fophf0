import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> checkClipboard(
  List<TextEditingController> controllers,
  List<FocusNode> _focusNodes,
) async {
  final clipboardData = await Clipboard.getData('text/plain');
  if (clipboardData != null) {
    final text = clipboardData.text ?? '';

    // Use RegExp to find a 4-digit number anywhere in the text
    final otpMatch = RegExp(r'\b\d{4}\b').firstMatch(text);

    if (otpMatch != null) {
      final otp = otpMatch.group(0)!; // the 4-digit OTP

      for (int i = 0; i < 4; i++) {
        controllers[i].text = otp[i];
      }

      _focusNodes[3].requestFocus(); // move focus to last field
    }
  }
}
