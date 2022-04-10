import 'dart:convert';
import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppHelps {
  static Future<bool> verificarConexao() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

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

  static String ajustaPath(String url) {
    if (url.contains('/')) url = url.replaceFirst('/', '');
    if (url.contains('/')) url = url.replaceAll('/', ' > ');
    if (url.contains('[1]')) url = url.replaceAll('[1]', '');
    if (url.contains('[2]')) url = url.replaceAll('[2]', '');
    if (url.contains('[3]')) url = url.replaceAll('[3]', '');
    if (url.contains('[4]')) url = url.replaceAll('[4]', '');
    if (url.contains('[5]')) url = url.replaceAll('[5]', '');
    if (url.contains('[6]')) url = url.replaceAll('[6]', '');
    if (url.contains('[7]')) url = url.replaceAll('[7]', '');
    if (url.contains('[8]')) url = url.replaceAll('[8]', '');
    if (url.contains('[9]')) url = url.replaceAll('[9]', '');
    if (url.contains('[10]')) url = url.replaceAll('[10]', '');

    return url;
  }

  static String removeUnicode(String id) {
    var simbolos = ['卍', '’', '–'];
    for (var item in simbolos) {
      id = id.replaceAll(item, '');
    }
    return id;
  }

  static String convertUniqueid(String manga) {
    return manga.replaceAll(RegExp('[^A-Za-z0-9]'), '');
  }

  static decode(value) {
    if (value is String) {
      return json.decode(value);
    }
    return value;
  }

  static void log(e) {
    var logger = Logger();
    try {
      logger.e(e, null);
    } catch (e) {
      logger.w(e, null);
    }
  }
}
