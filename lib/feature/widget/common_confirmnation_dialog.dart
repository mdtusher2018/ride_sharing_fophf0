import 'package:flutter/material.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_button.dart';

void commonConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelButtonText,
  required String actionButtonText,
  required VoidCallback onCancel,
  required VoidCallback onAction,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,

        title: CommonText(title, size: 18, fontWeight: FontWeight.bold),
        content: CommonText(message, size: 16, fontWeight: FontWeight.normal),
        actions: <Widget>[
          SizedBox(
            height: 40,
            child: Row(
              spacing: 16,

              children: [
                Expanded(
                  child: CommonButton(
                    cancelButtonText,
                    onTap: () {
                      onCancel();
                    },
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                  child: CommonButton(
                    actionButtonText,
                    onTap: () {
                      onAction();
                    },
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
