import 'dart:convert';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppHelps {
  static void confirmaDialog({
    required String title,
    required String content,
    required void Function()? confime,
  }) {
    Get.defaultDialog(
      title: title,
      // middleText: content,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      content: Text(
        content,
        style: Get.textTheme.subtitle1,
        textAlign: TextAlign.justify,
      ),
      confirm: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () => Get.back(),
            child: Text(
              'Não',
              style: Get.textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: confime,
            child: Text(
              'Sim',
              style: Get.textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
