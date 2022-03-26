import 'package:flutter/material.dart';

Future<bool> dialogBox(context) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(25),
      title: const Text('Delete Task'),
      content: const Text('Are you sure you want to delete this Task?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
      ],
    ),
  );
}
