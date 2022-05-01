import 'package:flutter/material.dart';

class AppHelps {
  static Future<bool> confirmaDialog({
    required String title,
    required String content,
    void Function()? confime,
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

  static bottomSheet({
    required BuildContext context,
    Widget? child,
    bool isScrollControlled = false,
    ShapeBorder? shape,
  }) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => child ?? Container(),
      isScrollControlled: isScrollControlled,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
    );
  }
}
