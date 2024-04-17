import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmButtonText = 'OK',
  Function()? onCancel,
  required Function() onConfirm,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (onCancel != null)
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                onCancel();
              },
              child: const Text('Não'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(confirmButtonText),
          ),
        ],
      );
    },
  );
}
