import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppHelps {
  static Future<bool> confirmaDialog({
    required String title,
    String? content,
    void Function()? confime,
    required BuildContext context,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: content != null ? Text(content) : null,
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

  static Future bottomSheet({
    required BuildContext context,
    Widget? child,
    bool isScrollControlled = false,
    ShapeBorder? shape,
  }) async {
    return await showModalBottomSheet(
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
