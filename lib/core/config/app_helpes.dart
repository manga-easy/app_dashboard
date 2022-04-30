import 'package:flutter/material.dart';

class AppHelps {
  static Future<bool> confirmaDialog({
    required String title,
    required String content,
    required void Function()? confime,
    required BuildContext context,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: confime ?? () => Navigator.pop(context, true),
                child: const Text('OK'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
